class GoalDonationPointTransaction < ActiveRecord::Base
  attr_accessible :goal_donation_id, :goal_id, :point_amount, :user_id, :active
  attr_accessible :user, :goal
  attr_accessible :redemption_point_transaction_id
  
  belongs_to :user
  belongs_to :goal
  belongs_to :goal_donation
  belongs_to :redemption_point_transaction

  def redeemed?
    redemption_point_transaction_id?
  end
  
end
