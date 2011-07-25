class ConferencesAddOrganizationId < ActiveRecord::Migration
  def self.up
    add_column :conferences, :organization_id, :integer
  end

  def self.down
    remove_column :conferences, :organization_id
  end
end
