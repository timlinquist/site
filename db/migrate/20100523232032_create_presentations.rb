class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.integer :presenter_id
      t.integer :video_id 

      t.timestamps
    end

    restore_table_from_fixture "presentations", "-original"
  end

  def self.down
    save_table_to_fixture "presentations", "-original"

    drop_table :presentations
  end
end
