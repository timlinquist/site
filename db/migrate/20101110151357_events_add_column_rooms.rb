class EventsAddColumnRooms < ActiveRecord::Migration
  def self.up
    add_column :events, :rooms, :integer
    restore_table_from_fixture 'events', '-rooms'
  end

  def self.down
    save_table_to_fixture 'events', '-rooms'
    remove_column :events, :rooms
  end
end
