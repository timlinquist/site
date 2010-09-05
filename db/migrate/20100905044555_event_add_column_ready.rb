class EventAddColumnReady < ActiveRecord::Migration
  def self.up
    add_column :events, :ready, :boolean, :default => true

    restore_table_from_fixture "events", "-ready"
  end

  def self.down
    save_table_to_fixture "events", "-ready"
    remove_column :events, :ready
  end
end
