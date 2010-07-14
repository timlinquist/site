class CreateAssetTypes < ActiveRecord::Migration
  def self.up
    create_table :asset_types do |t|
      t.string :description
      t.boolean :streaming

      t.timestamps
    end

    restore_table_from_fixture "asset_types"
  end

  def self.down
    save_table_to_fixture "asset_types"

    drop_table :asset_types
  end
end
