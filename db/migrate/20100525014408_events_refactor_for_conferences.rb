class EventsRefactorForConferences < ActiveRecord::Migration
  def self.up
    remove_column :events, :name
    add_column :events, :conference_id, :integer

    restore_table_from_fixture "events", "-refactor-conferences"
  end

  def self.down
    save_table_to_fixture "events", "-refactor-conferences"

    add_column :events, :name, :string
    remove_column :events, :conference_id
  end
end
