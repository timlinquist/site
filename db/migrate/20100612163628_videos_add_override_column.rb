class VideosAddOverrideColumn < ActiveRecord::Migration
  def self.up
    add_column :videos, :override, :string

    restore_table_from_fixture "video","_override"
  end

  def self.down
    save_table_to_fixture "video", "_override"

    remove_column :videos, :override
  end
end
