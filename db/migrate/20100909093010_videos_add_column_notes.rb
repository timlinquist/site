class VideosAddColumnNotes < ActiveRecord::Migration
  def self.up
    add_column :videos, :note, :text

    restore_table_from_fixture "videos","-note"
  end

  def self.down
    save_table_to_fixture "videos", "-note"
    remove_column :videos, :note
  end
end
