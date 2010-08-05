class UsersAddColumnRepScore < ActiveRecord::Migration
  def self.up
    add_column :users, :rep_score, :integer, :default => 0

    restore_table_from_fixture "users","-rep_score"
  end

  def self.down
    save_table_to_fixture "users", "-rep_score"

    remove_column :users, :rep_score
  end
end
