class ConferencesDropEventId < ActiveRecord::Migration
  def self.up
    remove_column :conferences, :event_id

    restore_table_from_fixture "conferences","-event_id"
  end

  def self.down
    save_table_to_fixture "conferences", "-event_id"

    add_column :conferences, :event_id, :integer
  end
end
