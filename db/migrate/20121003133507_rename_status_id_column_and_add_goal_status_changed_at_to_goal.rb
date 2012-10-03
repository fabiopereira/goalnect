class RenameStatusIdColumnAndAddGoalStatusChangedAtToGoal < ActiveRecord::Migration
  def change
    rename_column :goals, :status_id, :goal_stage_id
    add_column :goals, :goal_stage_changed_at, :datetime
  end
end
