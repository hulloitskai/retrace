# typed: true
# frozen_string_literal: true

class ICloudPhotosImportSerializer < ApplicationSerializer
  # == Configuration
  object_as :import, model: "ICloudPhotosImport"

  # == Attributes
  identifier
  attributes :created_at,
             download_count: { type: :number },
             completed_download_count: { type: :number }
end
