class GoalDonation < ActiveRecord::Base
  MIN_AMOUNT = 10
  
  attr_accessible :amount, :goal_id, :message, :user_id, :current_status, :donor_name, :processed, :created_at, :goalnect_fee, :pagseguro_fee, :goal, :charity_id
  
  belongs_to :goal, :class_name => 'Goal', :foreign_key => 'goal_id'
  belongs_to :user
  
  validates_presence_of :goal_id, :amount, :donor_name
  validates :amount, :numericality => { :greater_than_or_equal_to => MIN_AMOUNT }
  
  def displayed_status
    current_status ? current_status : 'waiting_notification'
  end
  
  def self.find_most_recent_donations_by_goal_id goal_id
    GoalDonation.where("goal_id = ?", goal_id).order('id DESC').limit(5)
  end
  
  def self.find_most_recent_donations_by_charity_id charity_id
    GoalDonation.where("charity_id = ?", charity_id).order('id DESC').limit(10)
  end
  
  def self.find_total_raised_amount_by_charity_id charity_id
    GoalDonation.sum(:amount, :conditions => ["charity_id = ?", charity_id])
  end
  
  def self.find_all_between_dates_by_charity charity_id, from, to
    GoalDonation.where("charity_id = ? and created_at between ? and ?", charity_id, from, to).order("id") 
  end
  
  def self.sum_donation_amount_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:amount, :conditions => ["charity_id = ? and created_at between ? and ?", charity_id, from, to])
  end
  
  def self.sum_pagseguro_fees_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:pagseguro_fee, :conditions => ["charity_id = ? and created_at between ? and ?", charity_id, from, to])
  end
  
  def self.sum_goalnect_fees_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:goalnect_fee, :conditions => ["charity_id = ? and created_at between ? and ?", charity_id, from, to])
  end
end
