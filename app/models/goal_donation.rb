class GoalDonation < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :message, :user_id, :current_status, :donor_name
  
  validates_presence_of :goal_id, :amount, :donor_name
  validates :amount, :numericality => { :greater_than_or_equal_to => 10 }
  
  def displayed_status
    current_status ? current_status : 'waiting_notification'
  end
   
end
