class EventsAddColumnDisplay < ActiveRecord::Migration
  def self.up
    add_column :events, :display, :boolean, :default => true

    restore_table_from_fixture "events", "-display"
  end

  def self.down
    remove_column :events, :display

    save_table_to_fixture "events", "-display"
  end
end
