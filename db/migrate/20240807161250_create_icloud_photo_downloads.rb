# typed: true
# frozen_string_literal: true

class CreateICloudPhotoDownloads < ActiveRecord::Migration[7.1]
  def change
    create_table :icloud_photo_downloads, id: :uuid do |t|
      t.belongs_to :import,
                   null: false,
                   foreign_key: { to_table: "icloud_photos_imports" },
                   type: :uuid
      t.string :webpage_url, null: false, index: { unique: true }
      t.timestamptz :downloaded_at

      t.timestamps
    end
  end
end
