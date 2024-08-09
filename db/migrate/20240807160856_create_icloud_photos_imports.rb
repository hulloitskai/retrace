# typed: true
# frozen_string_literal: true

class CreateICloudPhotosImports < ActiveRecord::Migration[7.1]
  def change
    create_table :icloud_photos_imports, id: :uuid do |t|
      t.belongs_to :album, null: false, foreign_key: true, type: :uuid
      t.string :webpage_url, null: false, index: { unique: true }
      t.timestamptz :indexed_at

      t.timestamps
    end
  end
end
