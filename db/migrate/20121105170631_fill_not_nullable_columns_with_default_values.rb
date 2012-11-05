class FillNotNullableColumnsWithDefaultValues < ActiveRecord::Migration
  def up
    GoalDonation.update_all("current_stage_id = 1", "current_stage_id is null")
    GoalDonationPaymentNotification.update_all("stage_id = 1", "stage_id is null")
    Goal.update_all("charity_id = 1", "charity_id is null")
    Goal.update_all("goal_stage_id = 3", "goal_stage_id is null")
    GoalFeedback.update_all("goal_stage_id = 3", "goal_stage_id is null")
  end
  
  def down
  end
end
