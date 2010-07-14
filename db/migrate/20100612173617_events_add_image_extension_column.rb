class EventsAddImageExtensionColumn < ActiveRecord::Migration
  def self.up
    add_column :events, :image_extension, :string, :default => 'png'

    restore_table_from_fixture "events","_image_extension"
  end

  def self.down
    save_table_to_fixture "events", "_image_extension"

    remove_column :events, :image_extension
  end
end
