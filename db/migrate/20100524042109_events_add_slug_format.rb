class EventsAddSlugFormat < ActiveRecord::Migration
  def self.up
    add_column :events, :slug_format_data, :string, :default => "display_presenters, title"

    restore_table_from_fixture "videos","-slug_format"
  end

  def self.down
    save_table_to_fixture "videos", "-slug_format"

    remove_column :events, :slug_format_data
  end
end
