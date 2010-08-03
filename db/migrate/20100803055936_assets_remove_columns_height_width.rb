class AssetsRemoveColumnsHeightWidth < ActiveRecord::Migration
  def self.up
    remove_column :assets, :height
    remove_column :assets, :width

    restore_table_from_fixture "assets","-height-width-removal"
  end

  def self.down
    save_table_to_fixture "assets", "-height-width-removal"
    
    add_column :assets, :height, :integer
    add_column :assets, :width, :integer
  end
end
