# typed: strict
# frozen_string_literal: true

class DownloadICloudPhotoDownloadJob < BrowsingJob
  # == Job
  sig { params(download: ICloudPhotoDownload).void }
  def perform(download)
    download.download
  end
end
