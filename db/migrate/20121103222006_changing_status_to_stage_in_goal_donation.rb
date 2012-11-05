class ChangingStatusToStageInGoalDonation < ActiveRecord::Migration
  
  def up          
    add_column :goal_donations, :current_stage_id, :integer   
    add_column :goal_donation_payment_notifications, :stage_id, :integer   
    remove_column :goal_donations, :current_status
    remove_column :goal_donation_payment_notifications, :status
  end
  
  def down
  end
end
