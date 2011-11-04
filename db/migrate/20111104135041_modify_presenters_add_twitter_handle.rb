class ModifyPresentersAddTwitterHandle < ActiveRecord::Migration
  def self.up
    add_column :presenters, :twitter_handle, :string

    restore_table_from_fixture "presenters", "-twitter-handle"
  end

  def self.down
    save_table_to_fixture "presenters", "-twitter-handle"
    remove_column :presenters, :twitter_handle
  end
end
