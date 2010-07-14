class EventsAddSlugDateFormat < ActiveRecord::Migration
  def self.up
    add_column :events, :slug_date_format, :string, :default => '%Y-%m-%d-%H-%M-'

    restore_table_from_fixture "events", "-slug_date_format"
  end

  def self.down
    save_table_to_fixture "events", "-slug_date_format"

    remove_column :events, :slug_date_format
  end
end
