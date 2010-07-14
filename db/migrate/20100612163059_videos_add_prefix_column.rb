class VideosAddPrefixColumn < ActiveRecord::Migration
  def self.up
    add_column :videos, :prefix, :string

    restore_table_from_fixture 'videos','_prefix'
  end

  def self.down
    save_table_to_fixture 'videos', '_prefix'

    remove_column :videos, :prefix
  end
end
