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
  after_create_commit :broadcast_album_download_created

  private

  # == Callback handlers
  sig { void }
  def broadcast_album_download_created
    AlbumDownloadCreatedChannel.broadcast(self)
  end
end
