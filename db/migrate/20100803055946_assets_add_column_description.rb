class AssetsAddColumnDescription < ActiveRecord::Migration
  def self.up
    add_column :assets, :description, :string

    restore_table_from_fixture "assets","-description"
  end

  def self.down
    save_table_to_fixture "assets", "-description"
    remove_column :assets, :description
  end
end
