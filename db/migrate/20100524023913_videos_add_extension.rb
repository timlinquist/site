class VideosAddExtension < ActiveRecord::Migration
  def self.up
    add_column :videos, :extension, :string

    restore_table_from_fixture "videos", "-extension"
  end

  def self.down
    save_table_to_fixture "videos", "-extension"

    remove_column :videos, :extension
  end
end
