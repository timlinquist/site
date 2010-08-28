class VideosAddColumnRating < ActiveRecord::Migration
  def self.up
    add_column :videos, :rating, :string, :default => "Everyone"
    restore_table_from_fixture "videos", "-rating"
  end

  def self.down
    save_table_to_fixture "videos", "-rating"
    remove_column :videos, :rating
  end
end
