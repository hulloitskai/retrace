# typed: true
# frozen_string_literal: true

class AddUniquenessConstraintToICloudPhotosImports < ActiveRecord::Migration[7.1] # rubocop:disable Layout/LineLength
  def change
    add_index :icloud_photos_imports, %i[webpage_url album_id], unique: true
  end
end
