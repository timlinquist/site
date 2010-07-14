class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title
      t.datetime :recorded_at
      t.integer :event_id
      t.string :format
      t.timestamps
    end

    restore_table_from_fixture "videos", "-original"
  end

  def self.down
    save_table_to_fixture "videos", "-original"

    drop_table :videos
  end
end
