class GoalDonationPointTransaction < ActiveRecord::Base
  attr_accessible :goal_donation_id, :goal_id, :point_amount, :user_id, :active
  
  belongs_to :user, :goal
                                  
  def self.find_by_username(username)
    find(:all, :conditions => ['user.username = ?', username])
  end
  
end
