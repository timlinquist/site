class VideosAddColumnIncludeRandom < ActiveRecord::Migration
  def self.up
    add_column :videos, :include_random, :boolean, :default => true
    restore_table_from_fixture "videos", "-include_random"
  end

  def self.down
    save_table_to_fixture "videos", "-include_random"
    remove_column :videos, :include_random
  end
end
