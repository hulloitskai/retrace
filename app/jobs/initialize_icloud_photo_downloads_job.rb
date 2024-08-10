# typed: strict
# frozen_string_literal: true

class InitializeICloudPhotoDownloadsJob < BrowsingJob
  # == Job
  sig { params(import: ICloudPhotosImport).void }
  def perform(import)
    import.initialize_downloads
  end
end
