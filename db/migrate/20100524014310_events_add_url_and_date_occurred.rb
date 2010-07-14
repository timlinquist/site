class EventsAddUrlAndDateOccurred < ActiveRecord::Migration
  def self.up
    add_column :events, :url, :string
    add_column :events, :date_occurred, :string

    restore_table_from_fixture "events","-url_date_occurred"
  end

  def self.down
    save_table_to_fixture "events", "-url_date_occurred"

    remove_column :events, :url
    remove_column :events, :date_occurred
  end
end
