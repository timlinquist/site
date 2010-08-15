class VideosAddColumnsImageAndStreamingAssetId < ActiveRecord::Migration
  def self.up
    add_column :videos, :image_file_name, :string
    add_column :videos, :image_content_type, :string
    add_column :videos, :image_file_size, :integer
    add_column :videos, :image_updated_at, :datetime

    add_column :videos, :streaming_asset_id, :integer

    restore_table_from_fixture "videos","-image-streaming-asset-id"
  end

  def self.down
    save_table_to_fixture "videos", "-image-streaming-asset-id"

    remove_column :videos, :image_file_name
    remove_column :videos, :image_content_type
    remove_column :videos, :image_file_size
    remove_column :videos, :image_updated_at
    remove_column :videos, :streaming_asset_id
  end
end
