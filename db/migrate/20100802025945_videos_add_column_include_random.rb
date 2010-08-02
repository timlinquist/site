class VideosAddColumnIncludeRandom < ActiveRecord::Migration
  def self.up
    add_column :videos, :include_random, :boolean, :default => true
  end

  def self.down
    remove_column :videos, :include_random
  end
end
