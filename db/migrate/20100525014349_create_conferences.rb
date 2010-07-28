class CreateConferences < ActiveRecord::Migration
  def self.up
    create_table :conferences do |t|
      t.integer :event_id
      t.string :name

      t.timestamps

      restore_table_from_fixture "conferences"
    end
  end

  def self.down
    save_table_to_fixture "conferences"

    drop_table :conferences
  end
end
