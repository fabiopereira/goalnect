class GoalDonationPointTransaction < ActiveRecord::Base
  attr_accessible :goal_donation_id, :goal_id, :point_amount, :user_id, :active
  attr_accessible :user, :goal
  
  belongs_to :user
  belongs_to :goal
  belongs_to :goal_donation
  
end
