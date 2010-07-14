class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :year
      t.string :short_code
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    restore_table_from_fixture "events", "original"
  end

  def self.down
    save_table_to_fixture "events", "original"

    drop_table :events
  end
end
