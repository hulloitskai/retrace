# typed: strict
# frozen_string_literal: true

class SaveICloudPhotoDownloadPhotoJob < ApplicationJob
  # == Configuration
  good_job_control_concurrency_with(
    key: -> {
      T.bind(self, SaveICloudPhotoDownloadPhotoJob)
      download = T.let(arguments.first!, ICloudPhotoDownload)
      "#{self.class.name}(#{download.to_gid})"
    },
    total_limit: 1,
  )

  # == Job
  sig { params(download: ICloudPhotoDownload).void }
  def perform(download)
    download.save_photo
  rescue => error
    with_log_tags do
      logger.warn(
        "Failed to save photo from download #{download.id}: #{error.message}",
      )
    end
  end
end
