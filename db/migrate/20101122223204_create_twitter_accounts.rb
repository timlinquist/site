class CreateTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table :twitter_accounts do |t|
      t.integer :user_id
      t.string :token
      t.string :secret
      t.timestamps
    end

    restore_table_from_fixtures "twitter_accounts","-original"
  end

  def self.down
    save_table_to_fixtures "twitter_accounts","-original"

    drop_table :twitter_accounts
  end
end
