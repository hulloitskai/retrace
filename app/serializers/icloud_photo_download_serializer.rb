# typed: true
# frozen_string_literal: true

class ICloudPhotoDownloadSerializer < ApplicationSerializer
  # == Configuration
  object_as :download, model: "ICloudPhotoDownload"

  # == Attributes
  identifier
  attributes :webpage_url

  # == Associations
  has_one :image_blob, as: :image, serializer: ImageSerializer, nullable: true
end
