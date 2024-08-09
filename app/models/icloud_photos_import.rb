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

  # == Associations
  belongs_to :album, inverse_of: :imports
  has_many :downloads,
           class_name: "ICloudPhotoDownload",
           dependent: :destroy,
           inverse_of: :import,
           foreign_key: :import_id

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
      first_item.click
      skipped_urls = []
      (0...item_count).each do |i|
        with_log_tags do
          logger.info("Processing carousel item #{i}")
        end
        before_load_webpage_timestamp = Time.current
        begin
          page.wait_for_url("**/#{i}/", timeout: 1000)
        rescue Playwright::TimeoutError
          raise unless page.url.ends_with?("/#{i}/")
        end
        with_log_tags do
          load_time = Time.current - before_load_webpage_timestamp
          logger.info(
            "  Loaded webpage: #{page.url}, took " \
              "#{load_time.round(2)}s",
          )
        end
        carousel_item_classes = content_frame
          .locator(".OneUpCarouselItem.is-center .ProgressiveImageElement")
          .wait_for(state: "attached")
          .get_attribute("class")
          .split(" ")
        if carousel_item_classes.exclude?("VideoPlayer-progressiveImage")
          with_log_tags do
            logger.info("  Found photo; creating download")
          end
          downloads.find_or_create_by!(webpage_url: page.url)
          with_log_tags do
            logger.info("  Created download")
          end
        else
          skipped_urls << page.url
          with_log_tags do
            logger.info("  Found video; skipping")
          end
        end
        page.keyboard.press("ArrowRight")
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
