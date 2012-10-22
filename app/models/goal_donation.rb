class GoalDonation < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :message, :user_id, :current_status, :donor_name, :processed
  
  validates_presence_of :goal_id, :amount, :donor_name
  validates :amount, :numericality => { :greater_than_or_equal_to => 10 }
  
  def displayed_status
    current_status ? current_status : 'waiting_notification'
  end
  
  def self.find_most_recent_donations_by_goal_id goal_id
    GoalDonation.where("goal_id = ?", goal_id).order('id DESC').limit(5)
  end
end
