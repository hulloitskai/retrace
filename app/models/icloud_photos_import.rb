# typed: true
# frozen_string_literal: true

# rubocop:disable Layout/LineLength, Lint/RedundantCopDisableDirective
#
# == Schema Information
#
# Table name: icloud_photos_imports
#
#  id                       :uuid             not null, primary key
#  downloads_initialized_at :datetime
#  webpage_url              :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  album_id                 :uuid             not null
#
# Indexes
#
#  index_icloud_photos_imports_on_album_id                  (album_id)
#  index_icloud_photos_imports_on_webpage_url               (webpage_url) UNIQUE
#  index_icloud_photos_imports_on_webpage_url_and_album_id  (webpage_url,album_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#
# rubocop:enable Layout/LineLength, Lint/RedundantCopDisableDirective
class ICloudPhotosImport < ApplicationRecord
  include Identifiable

  # == Attributes
  sig { returns(T::Boolean) }
  def downloads_initialized? = downloads_initialized_at?

  # == Associations
  belongs_to :album, inverse_of: :imports
  has_many :downloads,
           class_name: "ICloudPhotoDownload",
           dependent: :destroy,
           inverse_of: :import,
           foreign_key: :import_id

  sig { returns(Album) }
  def album!
    album or raise ActiveRecord::RecordNotFound, "Missing album"
  end

  # == Validations
  validates :webpage_url,
            presence: true,
            url: true,
            format: {
              with: %r{\A(https://www\.icloud\.com/photos/#[a-zA-Z0-9_-]+)|(https://share\.icloud\.com/photos/[a-zA-Z0-9_-]+)\z},
              message: "is not a valid iCloud photos link",
            },
            uniqueness: { scope: :album }

  # == Normalization
  before_save :normalize_webpage_url, if: :will_save_change_to_webpage_url?

  # == Callbacks
  after_create_commit :initialize_downloads_later

  # == Downloads
  sig { returns(T.nilable(Integer)) }
  def download_count
    downloads.count if downloads_initialized?
  end

  sig { returns(Integer) }
  def completed_download_count
    downloads.completed.count
  end

  sig { void }
  def initialize_downloads
    BrowsingService.open_page do |page|
      page.goto(webpage_url)
      content_frame = page.frame(name: "early-child")
      item_count = scoped do
        div = content_frame.locator(".placard-count").first
        match = div.text_content.match(/\A([0-9]+) selected\z/)
        T.must(match).captures.first!.to_i
      end
      first_item = content_frame.locator(".PhotoItemView").first
      first_item.locator("img").wait_for(state: "attached")
      page.expect_navigation { first_item.click }
      skipped_urls = []
      (0...item_count).each do |i|
        with_log_tags { logger.info("Processing carousel item #{i + 1}") }
        carousel_item_classes = content_frame
          .locator(".OneUpCarouselItem.is-center .ProgressiveImageElement")
          .first
          .wait_for(state: "attached")
          .get_attribute("class")
          .split(" ")
        if carousel_item_classes.exclude?("VideoPlayer-progressiveImage")
          with_log_tags { logger.info("  Found photo; creating download") }
          downloads.find_or_create_by!(webpage_url: page.url)
          with_log_tags { logger.info("  Created download") }
        else
          skipped_urls << page.url
          with_log_tags { logger.info("  Found video; skipping") }
        end
        if i == item_count - 1
          page.expect_navigation { page.keyboard.press("ArrowRight") }
        end
      end
      update!(downloads_initialized_at: Time.current)
      with_log_tags do
        logger.info("Downloads for import initialized (#{saved_id!})")
        if skipped_urls.any?
          logger.info("Downloads skipped for: #{skipped_urls.to_sentence}")
        end
      end
    end
  end

  sig { void }
  def initialize_downloads_later
    InitializeICloudPhotoDownloadsJob.perform_later(self)
  end

  sig { void }
  def download_pending_later
    downloads.pending.find_each(&:download_later)
  end

  private

  # == Normalizers
  sig { void }
  def normalize_webpage_url
    url = Addressable::URI.parse(webpage_url)
    if url.hostname == "share.icloud.com"
      url.hostname = "www.icloud.com"
      match = url.path.match(%r{\A/photos/([a-zA-Z0-9_-]+)\z})
      if match && (identifier = match.captures.first)
        url.path = "/photos/"
        url.fragment = identifier
      end
    end
    self.webpage_url = url.to_s
  end
end
