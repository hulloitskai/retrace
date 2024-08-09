# typed: true
# frozen_string_literal: true

# rubocop:disable Layout/LineLength, Lint/RedundantCopDisableDirective
#
# == Schema Information
#
# Table name: photos
#
#  id          :uuid             not null, primary key
#  coordinates :geometry         point, 0
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album_id    :uuid             not null
#  download_id :uuid             not null
#
# Indexes
#
#  index_photos_on_album_id     (album_id)
#  index_photos_on_download_id  (download_id)
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

  # == Attachments
  has_one_attached :image
end
