# typed: strict
# frozen_string_literal: true

class CreatePhotoFromICloudPhotoDownloadJob < ApplicationJob
  # == Job
  sig { params(download: ICloudPhotoDownload).void }
  def perform(download)
    Photo.from_download(download)
  end
end
