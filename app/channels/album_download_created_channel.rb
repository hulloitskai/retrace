# typed: true
# frozen_string_literal: true

class AlbumDownloadCreatedChannel < ApplicationCable::Channel
  # == Handlers
  def subscribed
    album = Album.find(album_id!)
    stream_for([album, :download_created])
  rescue StandardError => error
    Rails.error.report(error)
    reject_with(error.message)
  end

  # == Helpers
  sig { params(download: ICloudPhotoDownload).void }
  def self.broadcast(download)
    broadcast_to([download.album!, :download_created], {
      "downloadWebpageUrl" => download.webpage_url,
    })
  end

  private

  # == Helpers
  sig { returns(AlbumDownloadCreatedParameters) }
  def album_download_created_params
    @album_download_created_params ||= AlbumDownloadCreatedParameters
      .new(params)
  end

  sig { returns(String) }
  def album_id!
    album_download_created_params.album_id or raise "Missing album id"
  end
end
