class CreatePresenters < ActiveRecord::Migration
  def self.up
    create_table :presenters do |t|
      t.string :aka_name
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    restore_table_from_fixture "presenters","-original"
  end

  def self.down
    save_table_to_fixture "presenters","-original"

    drop_table :presenters
  end
end
