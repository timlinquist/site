class PresentersAddColumnTwitterHandle < ActiveRecord::Migration
  def self.up
    add_column :presenters, :twitter_handle, :string
  end

  def self.down
    remove_column :presenters, :twitter_handle
  end
end
