class EventsAddLogoFile < ActiveRecord::Migration
  def self.up
    add_column :events, :logo_file_name, :string
    add_column :events, :logo_content_type, :string
    add_column :events, :logo_file_size, :integer
    add_column :events, :logo_updated_at, :datetime

    restore_table_from_fixture "events","-logo-paperclip"
  end

  def self.down
    save_table_to_fixture "events","-logo-paperclip"

    remove_column :events, :logo_file_name
    remove_column :events, :logo_content_type
    remove_column :events, :logo_file_size
    remove_column :events, :logo_updated_at
  end
end
