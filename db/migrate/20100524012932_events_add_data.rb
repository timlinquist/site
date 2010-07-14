class EventsAddData < ActiveRecord::Migration
  def self.up
    add_column :events, :logo, :string

    restore_table_from_fixture "events","-logo"
  end

  def self.down
    save_table_to_fixture "events","-logo"

    remove_column :events, :logo
  end
end
