class VideosAddDisplayFormat < ActiveRecord::Migration
  def self.up
    add_column :videos, :display_format, :string
    remove_column :videos, :format

    restore_table_from_fixture "videos","_display_format"
  end

  def self.down
    save_table_to_fixture "videos", "_display_format"

    remove_column :videos, :display_format
    add_column :videos, :format, :string
  end
end
