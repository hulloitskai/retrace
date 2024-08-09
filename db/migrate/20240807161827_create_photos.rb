# typed: true
# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos, id: :uuid do |t|
      t.belongs_to :album, null: false, foreign_key: true, type: :uuid
      t.belongs_to :download,
                   null: false,
                   foreign_key: { to_table: "icloud_photo_downloads" },
                   type: :uuid
      t.st_point :coordinates

      t.timestamps
    end
  end
end
