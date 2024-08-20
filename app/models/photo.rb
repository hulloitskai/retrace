# typed: true
# frozen_string_literal: true

# rubocop:disable Layout/LineLength, Lint/RedundantCopDisableDirective
#
# == Schema Information
#
# Table name: photos
#
#  id          :uuid             not null, primary key
#  location    :geography        not null, point, 4326
#  taken_at    :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album_id    :uuid             not null
#  download_id :uuid             not null
#
# Indexes
#
#  index_photos_on_album_id               (album_id)
#  index_photos_on_album_id_and_taken_at  (album_id,taken_at)
#  index_photos_on_download_id            (download_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#  fk_rails_...  (download_id => icloud_photo_downloads.id)
#
# rubocop:enable Layout/LineLength, Lint/RedundantCopDisableDirective
class Photo < ApplicationRecord
  # == Associations
  belongs_to :album
  belongs_to :download, class_name: "ICloudPhotoDownload"
  has_one :import, through: :download

  sig { returns(ICloudPhotosImport) }
  def import!
    import or raise ActiveRecord::RecordNotFound, "Missing import"
  end

  # == Attachments
  has_one_attached :image

  # == Callbacks
  after_create_commit :broadcast_album_imports

  # == Geocoding
  sig { returns(RGeo::Geographic::Factory) }
  def self.location_factory
    RGeo::Geographic.spherical_factory(srid: 4326)
  end

  # == Helpers
  sig { params(file: Filelike).returns(T::Hash[String, T.untyped]) }
  def self.attributes_from_exif(file)
    info = Exiftool.new(file.to_path)
    latitude, longitude = info[:gps_latitude], info[:gps_longitude]
    raise "Missing GPS coordinates" unless latitude && longitude
    location = location_factory.point(longitude, latitude)
    taken_at = info[:sub_sec_date_time_original] or raise "Missing timestamp"
    { location:, taken_at: }
  end

  private

  # == Callback handlers
  sig { void }
  def broadcast_album_imports
    AlbumImportsChannel.broadcast(import!)
  end
end
