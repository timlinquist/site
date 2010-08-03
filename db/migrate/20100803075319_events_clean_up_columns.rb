class EventsCleanUpColumns < ActiveRecord::Migration
  def self.up
    remove_column :events, :slug_date_format
    remove_column :events, :joiner
    remove_column :events, :image_extension
    remove_column :events, :video_extension
    remove_column :events, :slug_format_data
    remove_column :events, :logo

    restore_table_from_fixture "events", "-clean_up"
  end

  def self.down
    save_table_to_fixture "events","-clean_up"
    add_column :events, :slug_date_format, :string, :default => "%Y-%m%d-%H-%M-"
    add_column :events, :joiner, :string, :default => "-"
    add_column :events, :image_extension, :string, :default => 'png'
    add_column :events, :video_extension, :string
    add_column :events, :slug_format_data, :string, :default => 'display_presenters, title'
    add_column :events, :logo
  end
end
