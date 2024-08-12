# typed: strict
# frozen_string_literal: true

class InitializeICloudPhotoDownloadsJob < BrowsingJob
  # == Configuration
  retry_on Playwright::TimeoutError, attempts: 3

  # == Job
  sig { params(import: ICloudPhotosImport).void }
  def perform(import)
    import.initialize_downloads
  end
end
