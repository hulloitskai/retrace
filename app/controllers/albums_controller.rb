# typed: true
# frozen_string_literal: true

class AlbumsController < ApplicationController
  # == Filters
  before_action :set_album, only: :show

  # == Actions
  # GET /albums/1
  def show
    raise "Missing album" unless @album
    render(inertia: "AlbumPage", props: {
      album: AlbumSerializer.one(@album),
      downloads: ICloudPhotoDownloadSerializer
        .many(@album.downloads.with_attached_image.chronological),
    })
  end

  # POST /albums
  def create
    @album = Album.new(album_params)
    if @album.save
      render(json: {
        album: AlbumSerializer.one(@album),
      })
    else
      errors = @album.form_errors.slice(:title)
      if (initial_import_errors = @album.initial_import&.form_errors.presence)
        initial_import_errors.each do |field, message|
          errors[:"initial_import_attributes.#{field}"] = message
        end
      end
      render(json: { errors: }, status: :unprocessable_entity)
    end
  end

  private

  # == Helpers
  def album_params
    params.require(:album).permit(
      :title,
      initial_import_attributes: :webpage_url,
    )
  end

  # == Filter handlers
  sig { void }
  def set_album
    @album = T.let(Album.friendly.find(params.fetch(:id)), T.nilable(Album))
  end
end
