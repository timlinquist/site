class VideosCleanUpColumns < ActiveRecord::Migration
  def self.up
    remove_column :videos, :display_format
    remove_column :videos, :prefix
    remove_column :videos, :override

    restore_table_from_fixture "videos","-clean_up"
  end

  def self.down
    save_table_to_fixture "videos","-clean_up"

    add_column :videos, :display_format, :string
    add_column :videos, :prefix, :string
    add_column :videos, :override
  end
end
