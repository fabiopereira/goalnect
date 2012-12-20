class UpdateAllPublishHomeGoalToTrue < ActiveRecord::Migration
  def up
    Goal.update_all("publish_home = true", "publish_home is null")
  end

  def down
  end
end
