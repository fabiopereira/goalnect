class ChangingStatusToStageInGoalDonation < ActiveRecord::Migration

  def migrate_status_to_stage
    status_to_stage = GoalnectPagseguroNotification::STATUS_TO_STAGE
    status_to_stage.each do |key, value|
      GoalDonation.update_all("current_stage_id = #{status_to_stage[key].id}", "current_status = '#{key.to_s}'")
      GoalDonationPaymentNotification.update_all("stage_id = #{status_to_stage[key].id}", "status = '#{key.to_s}'")
    end
  end
  
  def up          
    add_column :goal_donations, :current_stage_id, :integer   
    add_column :goal_donation_payment_notifications, :stage_id, :integer   
    remove_column :goal_donations, :current_status
    remove_column :goal_donation_payment_notifications, :status
  end
  
  def down
  end
end
