class AssetTypesAddColumnDownloadable < ActiveRecord::Migration
  def self.up
    add_column :asset_types, :downloadable, :boolean, :default => true
    
    restore_table_from_fixture "asset_types","-downloadable"
  end

  def self.down
    save_table_to_fixture "asset_types", "-downloadable"

    remove_column :asset_types, :downloadable
  end
end
