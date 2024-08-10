# typed: true
# frozen_string_literal: true

class ICloudPhotoDownloadsController < ApplicationController
  # == Filters
  before_action :set_download

  # == Actions
  # POST /icloud_photo_downloads/:id/download
  def download
    raise "Missing download" unless @download
    @download.download
    render(json: {
      download: ICloudPhotoDownloadSerializer.one(@download),
    })
  end

  private

  # == Filter handlers
  sig { void }
  def set_download
    @download = T.let(
      ICloudPhotoDownload.find(params.fetch(:id)),
      T.nilable(ICloudPhotoDownload),
    )
  end
end
