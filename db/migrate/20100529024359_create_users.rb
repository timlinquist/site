class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :username
      t.string    :email
      t.string    :password_hash
      t.string    :password_salt
      t.datetime  :last_login_date
      t.string    :time_zone
      t.string    :session_token
      t.boolean   :admin, :default => false
      t.string    :first_name
      t.string    :last_name
      t.string    :gender
      t.string    :location
      t.string    :avatar_file_name
      t.string    :avatar_content_type
      t.integer   :avatar_file_size
      t.datetime  :avatar_updated_at
      t.string    :twitter_name
      t.string    :facebook_token
      t.timestamps
    end

    restore_table_from_fixture "users", "-original"
  end

  def self.down
    save_table_to_fixture "users", "-original"
    drop_table :users
  end
end
