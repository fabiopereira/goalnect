class DropGoalAndGoalOptionTable < ActiveRecord::Migration
  def up
     drop_table :goals
     drop_table :goal_options
  end

  def down
  end
end
