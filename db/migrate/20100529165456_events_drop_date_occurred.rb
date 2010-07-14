class EventsDropDateOccurred < ActiveRecord::Migration
  def self.up
    remove_column :events, :date_occurred

    restore_table_from_fixture "events","-date_occurred"
  end

  def self.down
    save_table_to_fixture "events", "-date_occurred"

    add_column :events, :date_occured, :string
  end
end
