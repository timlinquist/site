class AssetsAddColumnZencoderOutputId < ActiveRecord::Migration
  def self.up
    add_column :assets, :zencoder_output_id, :integer
  end

  def self.down
    remove_column :assets, :zencoder_output_id
  end
end
