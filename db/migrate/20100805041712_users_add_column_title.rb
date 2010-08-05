class UsersAddColumnTitle < ActiveRecord::Migration
  def self.up
    add_column :users, :title, :string

    restore_table_from_fixture "users","-title"
  end

  def self.down
    save_table_to_fixture "users", "-title"

    remove_column :users, :title
  end
end
