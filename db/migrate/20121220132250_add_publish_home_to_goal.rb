class AddPublishHomeToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :publish_home, :boolean
  end
end
