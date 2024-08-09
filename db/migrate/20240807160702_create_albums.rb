# typed: true
# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums, id: :uuid do |t|
      t.string :title, null: false
      t.string :slug, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
