# typed: true
# frozen_string_literal: true

class AddUniqueConstraintToIndexPhotosOnDownloadId < ActiveRecord::Migration[7.1] # rubocop:disable Layout/LineLength
  def change
    remove_index :photos, :download_id
    add_index :photos, :download_id, unique: true
  end
end
