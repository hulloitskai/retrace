# typed: true
# frozen_string_literal: true

class AlbumImportsChannel < ApplicationCable::Channel
  # == Handlers
  def subscribed
    album = Album.find(album_id!)
    stream_for([album, :imports])
  rescue StandardError => error
    Rails.error.report(error)
    reject_with(error.message)
  end

  # == Helpers
  sig { params(import: ICloudPhotosImport).void }
  def self.broadcast(import)
    broadcast_to([import.album!, :imports], {
      import: ICloudPhotosImportSerializer.one(import),
    })
  end

  private

  # == Helpers
  sig { returns(AlbumImportsParameters) }
  def album_imports_params
    @album_imports_params ||= AlbumImportsParameters.new(params)
  end

  sig { returns(String) }
  def album_id!
    album_imports_params.album_id or raise "Missing album id"
  end
end
