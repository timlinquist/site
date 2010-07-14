class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer  :video_id
      t.integer  :asset_type_id
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_at
      t.integer  :width
      t.integer  :height

      t.timestamps
    end

    restore_table_from_fixture "assets"
  end

  def self.down
    save_table_to_fixture "assets"
    drop_table :assets
  end
end
