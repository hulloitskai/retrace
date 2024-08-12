# typed: true
# frozen_string_literal: true

class PhotoSerializer < ApplicationSerializer
  # == Attributes
  identifier :id

  attribute :location, type: "Point" do
    RGeo::GeoJSON.encode(photo.location)
  end

  # == Associations
  has_one :image, serializer: ImageSerializer
end
