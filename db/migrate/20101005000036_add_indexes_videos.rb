class AddIndexesVideos < ActiveRecord::Migration
  def self.up
    add_index(:videos, [:title], :name => "by_title")
  end

  def self.down
    remove_index(:videos, "by_title")
  end
end
