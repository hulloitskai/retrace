# typed: true
# frozen_string_literal: true

class ImageSerializer < FileSerializer
  # == Constants
  SIZES = [400, 940, 1400]

  # == Configuration
  object_as :blob, model: "ActiveStorage::Blob"

  # == Attributes
  attribute :src, type: :string do
    rails_representation_path(blob)
  rescue ActiveStorage::UnrepresentableError => error
    with_log_tags do
      logger.warn("Failed to get representation for Blob #{blob.id}: #{error}")
    end
    rails_blob_path(blob)
  end

  attribute :src_set, type: :string do
    sources = SIZES.map do |size|
      representation = blob.representation(resize_to_limit: [size, size])
      "#{rails_representation_path(representation)} #{size}w"
    end
    sources.join(", ")
  rescue ActiveStorage::UnrepresentableError => error
    with_log_tags do
      logger.warn("Failed to get representation for Blob #{blob.id}: #{error}")
    end
    [rails_blob_path(blob)]
  end
end
