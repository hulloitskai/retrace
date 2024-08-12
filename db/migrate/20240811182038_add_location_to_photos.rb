# typed: true
# frozen_string_literal: true

class AddLocationToPhotos < ActiveRecord::Migration[7.1]
  def change
    remove_column :photos, :coordinates
    add_column :photos,
               :location,
               :st_point,
               geographic: true,
               srid: 4326,
               null: false
  end
end
