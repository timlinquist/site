class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :message
      t.integer :user_id
      t.boolean :suppressed, :default => false

      t.timestamps
    end

    restore_table_from_fixture "activities", "-create"
  end

  def self.down
    save_table_to_fixture "activities", "-create"
    drop_table :activities
  end
end
