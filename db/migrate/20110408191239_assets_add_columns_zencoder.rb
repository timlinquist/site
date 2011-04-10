class AssetsAddColumnsZencoder < ActiveRecord::Migration
  def self.up
    add_column :assets, :zencoder_job_id, :integer
    add_column :assets, :zencoder_job_complete, :boolean, :default => false
    add_column :assets, :zencoder_response, :text
  end

  def self.down
    remove_column :assets, :zencoder_job_id
    remove_column :assets, :zencoder_job_complete
    remove_column :assets, :zencoder_response
  end
end
