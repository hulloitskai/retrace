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

  sig { returns(ICloudPhotosImport) }
  def import!
    import or raise ActiveRecord::RecordNotFound, "Missing import"
  end

  sig { returns(Album) }
  def album!
    album or raise ActiveRecord::RecordNotFound, "Missing album"
  end

  # == Attachments
  has_one_attached :image

  sig { override.returns(T.nilable(ActiveStorage::Blob)) }
  def image_blob
    blob = super
    blob&.image? ? blob : nil
  end

  # == Callbacks
  after_create_commit :download_later
  after_update_commit :save_photo_later, if: :image_previously_attached?
  after_commit :broadcast_album_imports,
               if: -> {
                 T.bind(self, ICloudPhotoDownload)
                 previously_new_record? ||
                   (downloaded_at_previously_changed? && downloaded?)
               }

  # == Scopes
  scope :pending, -> { where(downloaded_at: nil) }
  scope :completed, -> { where.not(downloaded_at: nil) }
  scope :photo_missing, -> { completed.where.missing(:photo) }

  # == Downloading
  sig { void }
  def download
    BrowsingService.open_page do |page|
      page.goto(webpage_url)
      content_frame = page.frame(name: "early-child")
      content_frame
        .locator(".OneUpCarouselItem.is-center .ProgressiveImageElement img")
        .first
        .wait_for(state: "visible")
      download_button = content_frame
        .locator("ui-button.DownloadButton")
        .first
      page.wait_for_load_state(state: "domcontentloaded")
      page.wait_for_timeout(400)
      with_log_tags do
        logger.info("Downloading file from: #{webpage_url}")
      end
      download = scoped do
        retries = T.let(0, Integer)
        begin
          page.expect_download(timeout: 8000) do
            download_button.click
          end
        rescue Playwright::TimeoutError
          raise if retries == 2
          retries += 1
          with_log_tags do
            logger.info(
              "  Timeout while clicking download button; retrying... " \
                "(attempt #{retries})",
            )
          end
          retry
        end
      end
      Dir.mktmpdir do |dir|
        filepath = File.join(dir, download.suggested_filename)
        with_log_tags do
          logger.info("  Saving file to: #{filepath}")
        end
        download.save_as(filepath)
        if (filepath = extract_downloaded_file(filepath, log_depth: 1))
          with_log_tags do
            logger.info("  Uploading file to ActiveStorage: #{filepath}")
          end
          File.open(filepath) do |f|
            image.attach(io: f, filename: File.basename(f.path))
          end
          update!(downloaded_at: Time.current)
          with_log_tags do
            logger.info("  File uploaded")
          end
        else
          with_log_tags do
            logger.info("  Download contains no images; skipping upload")
          end
        end
      end
    end
  end

  sig { void }
  def download_later
    DownloadICloudPhotoDownloadJob.perform_later(self)
  end

  # == Photos
  sig { returns(Photo) }
  def save_photo
    image_blob = self.image_blob or raise "Missing downloaded image"
    attributes = image_blob.open { |file| Photo.attributes_from_exif(file) }
    photo || create_photo!(
      album: album!,
      image: image_blob,
      **attributes,
    )
  end

  sig { void }
  def save_photo_later
    SaveICloudPhotoDownloadPhotoJob.perform_later(self)
  end

  private

  # == Helpers
  sig { returns(T::Boolean) }
  def image_previously_attached?
    image_blob&.previous_changes&.any?
  end

  sig do
    params(filepath: String, log_depth: Integer)
      .returns(T.nilable(String))
  end
  def extract_downloaded_file(filepath, log_depth: 0)
    log_prefix = "  " * log_depth
    download_type = MIME::Types.of(filepath).first!
    if download_type.media_type == "image"
      filepath
    elsif download_type.content_type == "application/zip"
      filepath = Zip::File.open(filepath) do |f|
        entry = f.find do |entry|
          entry_type = MIME::Types.of(entry.name).first!
          entry_type.media_type == "image"
        end or next
        dest_path = File.join(File.dirname(filepath), File.basename(entry.name))
        entry.extract(dest_path)
        dest_path
      end
      with_log_tags do
        logger.warn(log_prefix + "No image found in downloaded ZIP file")
      end unless filepath
      filepath
    else
      with_log_tags do
        logger.warn(
          log_prefix + "Unexpected download MIME type: #{download_type}",
        )
      end
      nil
    end
  end

  # == Callback handlers
  sig { void }
  def broadcast_album_imports
    AlbumImportsChannel.broadcast(import!)
  end
end
