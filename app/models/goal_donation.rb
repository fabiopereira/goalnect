class GoalDonation < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :message, :user_id, :current_status
  
  validates_presence_of :goal_id, :amount
   
end
