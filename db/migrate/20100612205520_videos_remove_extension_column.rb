class VideosRemoveExtensionColumn < ActiveRecord::Migration
  def self.up
    remove_column :videos, :extension

    restore_table_from_fixture "videos","_remove_extension"
  end

  def self.down
    save_table_to_fixture "videos", "_remove_extension"

    add_column :videos, :extension, :string
  end
end
