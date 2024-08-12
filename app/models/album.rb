# typed: true
# frozen_string_literal: true

# rubocop:disable Layout/LineLength, Lint/RedundantCopDisableDirective
#
# == Schema Information
#
# Table name: albums
#
#  id         :uuid             not null, primary key
#  slug       :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_albums_on_slug  (slug) UNIQUE
#
# rubocop:enable Layout/LineLength, Lint/RedundantCopDisableDirective
class Album < ApplicationRecord
  extend FriendlyId
  include Identifiable
  include Slugged

  # == FriendlyId
  friendly_id :title

  # == Associations
  has_many :photos, dependent: :destroy
  has_many :imports, class_name: "ICloudPhotosImport", dependent: :destroy
  has_many :downloads, through: :imports

  # == Validations
  validates :title, presence: true, length: { minimum: 3 }
  validates :initial_import, presence: true, on: :create
  validates_associated :initial_import, on: :create

  # == Imports
  sig { params(attributes: T.untyped).returns(ICloudPhotosImport) }
  def initial_import_attributes=(attributes)
    raise "Can only be set when creating a new album" if persisted?
    imports.build(attributes)
  end

  sig { returns(T.nilable(ICloudPhotosImport)) }
  def initial_import
    imports.first
  end

  # == Downloads
  sig { void }
  def download_pending_later
    downloads.pending.find_each(&:download_later)
  end

  # == Photos
  sig { void }
  def create_photos_from_downloads_later
    downloads.photo_missing.find_each(&:create_photo_later)
  end
end
