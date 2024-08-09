# typed: true
# frozen_string_literal: true

class RenameIndexedAtOnICloudPhotosImports < ActiveRecord::Migration[7.1]
  def change
    rename_column :icloud_photos_imports, :indexed_at, :downloads_initialized_at
  end
end
