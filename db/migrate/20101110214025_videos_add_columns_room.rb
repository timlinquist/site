class VideosAddColumnsRoom < ActiveRecord::Migration
  def self.up
    add_column :videos, :room_id, :integer, :default => 1

    restore_table_from_fixture "videos", "-rooms"
  end

  def self.down
    save_table_to_fixture "videos", "-rooms"

    remove_column :videos, :room_id
  end
end
