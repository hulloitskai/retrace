# typed: strict
# frozen_string_literal: true

class InitializeICloudPhotoDownloadsJob < ApplicationJob
  # == Configuration
  good_job_control_concurrency_with(
    key: -> {
      T.bind(self, InitializeICloudPhotoDownloadsJob)
      import = T.let(arguments.first!, ICloudPhotosImport)
      "#{self.class.name}(#{import.to_gid})"
    },
    total_limit: 1,
  )

  # == Job
  sig { params(import: ICloudPhotosImport).void }
  def perform(import)
    import.initialize_downloads
  end
end
