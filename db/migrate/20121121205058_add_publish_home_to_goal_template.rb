class AddPublishHomeToGoalTemplate < ActiveRecord::Migration
  def change
    add_column :goal_templates, :publish_home, :boolean
  end
end
