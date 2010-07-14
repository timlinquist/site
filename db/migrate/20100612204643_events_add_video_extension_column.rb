class EventsAddVideoExtensionColumn < ActiveRecord::Migration
  def self.up
    add_column :events, :video_extension, :string

    restore_table_from_fixture "events","_video_extension"
  end

  def self.down
    save_table_to_fixture "events", "_video_extension"

    remove_column :events, :video_extension
  end
end
