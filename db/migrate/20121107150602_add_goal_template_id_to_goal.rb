class AddGoalTemplateIdToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :goal_template_id, :integer
  end
end
