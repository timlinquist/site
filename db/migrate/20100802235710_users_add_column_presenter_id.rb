class UsersAddColumnPresenterId < ActiveRecord::Migration
  def self.up
    add_column :users, :presenter_id, :integer

    restore_table_from_fixture "users", "-presenter_id"
  end

  def self.down
    save_table_to_fixture "users", "-presenter_id"

    remove_column :users, :presenter_id
  end
end
