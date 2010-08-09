class EventsAddColumnNotes < ActiveRecord::Migration
  def self.up
    add_column :events, :notes, :text, :size => 4096

    restore_table_from_fixture "events", "-notes"
  end

  def self.down
    save_table_to_fixture "events", "-notes"

    remove_column :events, :notes
  end
end
