# typed: true
# frozen_string_literal: true

class AlbumDownloadsChannel < ApplicationCable::Channel
  # == Handlers
  def subscribed
    album = Album.find(album_id!)
    stream_for([album, :downloads])
  rescue StandardError => error
    Rails.error.report(error)
    reject_with(error.message)
  end

  # == Helpers
  sig { params(download: ICloudPhotoDownload).void }
  def self.broadcast(download)
    broadcast_to([download.album!, :downloads], {
      download: ICloudPhotoDownloadSerializer.one(download),
    })
  end

  private

  # == Helpers
  sig { returns(AlbumDownloadsParameters) }
  def album_downloads_params
    @album_downloads_params ||= AlbumDownloadsParameters.new(params)
  end

  sig { returns(String) }
  def album_id!
    album_downloads_params.album_id or raise "Missing album id"
  end
end
