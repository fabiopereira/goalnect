class AddImageToGoalTemplate < ActiveRecord::Migration
  def change
    add_column :goal_templates, :image, :string
  end
end
