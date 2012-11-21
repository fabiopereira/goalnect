class AddDueOnAndDescriptionGuideAndTypeToGoalTemplate < ActiveRecord::Migration
  def change
    add_column :goal_templates, :goal_template_type_id, :integer
    add_column :goal_templates, :description_guide, :string
    add_column :goal_templates, :due_on, :date
  end
end
