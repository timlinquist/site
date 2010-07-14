class EventsAddPrefixSuffixColumns < ActiveRecord::Migration
  def self.up
    add_column :events, :name_suffix, :string
    add_column :events, :name_prefix, :string
    remove_column :events, :year

    restore_table_from_fixture 'events', '-prefix-suffix'
  end

  def self.down
    save_table_to_fixture 'events', '-prefix-suffix'

    remove_column :events, :name_suffix
    remove_column :events, :name_prefix
    add_column :events, :year, :integer
  end
end
