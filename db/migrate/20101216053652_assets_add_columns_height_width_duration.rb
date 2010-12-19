class AssetsAddColumnsHeightWidthDuration < ActiveRecord::Migration
  def self.up
    add_column :assets, :height,   :integer, :default => 0
    add_column :assets, :width,    :integer, :default => 0
    add_column :assets, :duration, :string

    #restore_table_from_fixture "assets","-height-width-duration"

    assets = Asset.find(:all)

    assets.each do |asset|
      asset.width, asset.height, asset.duration = asset.get_metadata
      puts "Populating #{asset.id} - #{asset.width}x#{asset.height} - #{asset.duration}"
      asset.save
    end
  end

  def self.down
    #save_table_to_fixture "assets", "-height-width-duration"

    remove_column :assets, :height
    remove_column :assets, :width
    remove_column :assets, :duration
  end
end
