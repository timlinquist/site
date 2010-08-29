class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.string :controller
      t.string :action
      t.integer :user_id
      t.integer :param_id
      t.string :ip_address
      t.string :referrer
      t.string :url
      t.string :uri
      t.string :http_method
      t.string :query_string
      t.string :session_token
      t.string :user_agent
      t.string :protocol

      t.timestamps
    end

    restore_table_from_fixture "histories", "-original"
  end

  def self.down
    save_table_to_fixture "histories", "-original"

    drop_table :histories
  end
end
