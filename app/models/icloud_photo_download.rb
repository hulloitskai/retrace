# typed: true
# frozen_string_literal: true

# rubocop:disable Layout/LineLength, Lint/RedundantCopDisableDirective
#
# == Schema Information
#
# Table name: icloud_photo_downloads
#
#  id            :uuid             not null, primary key
#  downloaded_at :datetime
#  webpage_url   :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  import_id     :uuid             not null
#
# Indexes
#
#  index_icloud_photo_downloads_on_import_id    (import_id)
#  index_icloud_photo_downloads_on_webpage_url  (webpage_url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (import_id => icloud_photos_imports.id)
#
# rubocop:enable Layout/LineLength, Lint/RedundantCopDisableDirective
class ICloudPhotoDownload < ApplicationRecord
  include Identifiable

  # == Attributes
  sig { returns(T::Boolean) }
  def downloaded? = downloaded_at?

  # == Associations
  belongs_to :import, class_name: "ICloudPhotosImport", inverse_of: :downloads
  has_one :album, through: :import
  has_one :photo,
          dependent: :destroy,
          inverse_of: :download,
          foreign_key: :download_id

  sig { returns(Album) }
  def album!
    album or raise ActiveRecord::RecordNotFound, "Missing album"
  end

  # == Attachments
  has_one_attached :image

  # == Callbacks
  after_create_commit :download_later
  after_commit :broadcast_album_downloads,
               if: -> {
                 T.bind(self, ICloudPhotoDownload)
                 previously_new_record? ||
                   (downloaded_at_previously_changed? && downloaded?)
               }

  # == Scopes
  scope :pending, -> { where(downloaded_at: nil) }

  # == Downloading
  sig { void }
  def download
    BrowsingService.open_page do |page|
      page.goto(webpage_url)
      content_frame = page.frame(name: "early-child")
      content_frame
        .locator(".OneUpCarouselItem.is-center .ProgressiveImageElement")
        .wait_for(state: "visible")
      download_button = content_frame
        .locator("ui-button.DownloadButton")
        .first
      page.wait_for_load_state(state: "domcontentloaded")
      page.wait_for_timeout(400)
      download = scoped do
        retries = T.let(0, Integer)
        begin
          page.expect_download(timeout: 2000) do
            download_button.click
          end
        rescue Playwright::TimeoutError
          raise if retries == 2
          with_log_tags do
            logger.info("Timeout while clicking download button; retrying...")
          end
          retries += 1
          retry
        end
      end
      Dir.mktmpdir do |dir|
        filepath = File.join(dir, download.suggested_filename)
        download.save_as(filepath)
        image.attach(
          io: File.open(filepath),
          filename: download.suggested_filename,
        )
        update!(downloaded_at: Time.current)
      end
    end
  end

  sig { void }
  def download_later
    DownloadICloudPhotoDownloadJob.perform_later(self)
  end

  private

  # == Callback handlers
  sig { void }
  def broadcast_album_downloads
    AlbumDownloadsChannel.broadcast(self)
  end
end
