class VideosAddAvailable < ActiveRecord::Migration
  def self.up
    add_column :videos, :available, :boolean

    restore_table_from_fixture "videos", "-available"
  end

  def self.down
    save_table_to_fixture "videos", "-available"

    remove_column :videos, :available
  end
end
