# typed: strict
# frozen_string_literal: true

class CreatePhotoFromICloudPhotoDownloadJob < ApplicationJob
  # == Configuration
  good_job_control_concurrency_with(
    key: -> {
      T.bind(self, CreatePhotoFromICloudPhotoDownloadJob)
      download = T.let(arguments.first!, ICloudPhotoDownload)
      "#{self.class.name}(#{download.to_gid})"
    },
    total_limit: 1,
  )

  # == Job
  sig { params(download: ICloudPhotoDownload).void }
  def perform(download)
    Photo.from_download(download)
  end
end
