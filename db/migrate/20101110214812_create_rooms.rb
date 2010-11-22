class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :event_id
      t.integer :number
      t.string  :name
      t.timestamps
    end

    restore_table_from_fixture "rooms", "-original"
  end

  def self.down
    save_table_to_fixture "rooms", "-original"

    drop_table :rooms
  end
end
