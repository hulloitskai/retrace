# typed: true
# frozen_string_literal: true

class AlbumSerializer < ApplicationSerializer
  # == Attributes
  identifier
  attributes :title, :slug
end
