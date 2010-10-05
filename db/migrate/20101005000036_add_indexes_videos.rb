class AddIndexesVideos < ActiveRecord::Migration
  def self.up
    add_index(:videos, [:title], :name => "by_title")
    add_index(:videos, [:recorded_at], :name => "by_recorded_at")
  end

  def self.down
    remove_index(:videos, "by_title")
    remove_index(:videos, "by_recorded_at")
  end
end
