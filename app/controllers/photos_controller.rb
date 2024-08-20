# typed: true
# frozen_string_literal: true

class PhotosController < ApplicationController
  # == Actions
  # GET /photos
  def new
    render(inertia: "ImportPhotosPage")
  end
end
