class AddIndexesEvents < ActiveRecord::Migration
  def self.up
    add_index(:events, [:short_code], :name => "by_short_code")
    add_index(:videos, [:event_id], :name => "by_event_id")
    add_index(:histories, [:controller, :action, :param_id], 
              :name => "by_controller_action_param_id")
  end

  def self.down
    remove_index(:events, "by_short_code")
    remove_index(:videos, "by_event_id")
    remove_index(:histories, "by_controller_action_param_id")
  end
end
