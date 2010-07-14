class EventsAddJoinerColumn < ActiveRecord::Migration
  def self.up
    add_column :events, :joiner, :string, :default => "-"

    restore_table_from_fixture "events","_joiner"
  end

  def self.down
    remove_column :events, :joiner

    save_table_to_fixture "events","_joiner"
  end
end
