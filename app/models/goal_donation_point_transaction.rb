class GoalDonationPointTransaction < ActiveRecord::Base
  attr_accessible :goal_donation_id, :goal_id, :point_amount, :user_id, :active
  attr_accessible :user, :goal
  attr_accessible :redemption_point_transaction_id
  
  belongs_to :user
  belongs_to :goal
  belongs_to :goal_donation
  belongs_to :redemption_point_transaction

  def redeemed?
    
  end

  def status
    if !active && !redemption_point_transaction_id
      :locked
    elsif active && !redemption_point_transaction_id
      :available
    elsif redemption_point_transaction_id
      :redeemed
    else
      raise "Invalid status for #{YAML::dump(@self)}"
    end
  end  
  
end
