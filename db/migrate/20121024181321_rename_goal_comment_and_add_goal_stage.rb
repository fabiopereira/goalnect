class RenameGoalCommentAndAddGoalStage < ActiveRecord::Migration
  def change
    rename_table :goal_comments, :goal_feedbacks
    add_column :goal_feedbacks, :goal_stage_id, :integer   
  end
end
