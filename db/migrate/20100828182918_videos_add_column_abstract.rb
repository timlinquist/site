class VideosAddColumnAbstract < ActiveRecord::Migration
  def self.up
    add_column :videos, :abstract, :text, :default => ""

    restore_table_from_fixture "videos", "-abstract"
  end

  def self.down
    save_table_to_fixture "videos", "-abstract"

    remove_column :videos, :abstract
  end
end
