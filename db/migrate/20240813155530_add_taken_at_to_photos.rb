# typed: true
# frozen_string_literal: true

class AddTakenAtToPhotos < ActiveRecord::Migration[7.1]
  def change
    up_only { execute "DELETE FROM photos" }
    add_column :photos, :taken_at, :timestamptz, null: false
    add_index :photos, %i[album_id taken_at]
  end
end
