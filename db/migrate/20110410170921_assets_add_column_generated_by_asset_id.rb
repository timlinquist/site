class AssetsAddColumnGeneratedByAssetId < ActiveRecord::Migration
  def self.up
    add_column :assets, :generated_by_asset_id, :integer, :default => 0
  end

  def self.down
    remove_column :assets, :generated_by_asset_id
  end
end
