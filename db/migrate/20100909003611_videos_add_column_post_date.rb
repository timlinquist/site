class VideosAddColumnPostDate < ActiveRecord::Migration
  def self.up
    add_column :videos, :post_date, :datetime
    add_column :videos, :announce, :boolean, :default => false
    add_column :videos, :announce_date, :datetime

    restore_table_from_fixture "videos","-post_date-announce"
  end

  def self.down
    save_table_to_fixture "videos", "-post_date-announce"
    remove_column :videos, :post_date
    remove_column :videos, :announce
    remove_column :videos, :announce_date
  end
end
