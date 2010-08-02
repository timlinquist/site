class PresentersAddColumnUserId < ActiveRecord::Migration
  def self.up
    add_column :presenters, :user_id, :integer

    restore_table_from_fixture "presenters", "-user_id"
  end

  def self.down
    save_table_to_fixture "presenters", "-user_id"

    remove_column :presenters, :user_id
  end
end
