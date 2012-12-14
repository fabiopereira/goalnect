class GoalDonation < ActiveRecord::Base
  MIN_AMOUNT = 5
  
  attr_accessible :amount, :goal_id, :message, :user_id, :donor_name, :processed, :created_at, :updated_at, :goalnect_fee, :pagseguro_fee, :goal, :charity_id
  attr_accessible :current_stage_id
  
  belongs_to :goal, :class_name => 'Goal', :foreign_key => 'goal_id'
  belongs_to :user
  belongs_to :charity
  
  validates_presence_of :goal_id, :amount, :donor_name, :current_stage_id
  validates :amount, :numericality => { :greater_than_or_equal_to => MIN_AMOUNT }
  
  scope :approved, where("current_stage_id = #{GoalDonationStage::APPROVED.id}")
  scope :recent, order('id DESC')
  
  def decimal_amount
    amount.to_f
  end
  
  def current_stage
    raise "self.current_stage_id should never be nil" unless self.current_stage_id
    GoalDonationStage.find self.current_stage_id
  end
  
  def self.how_many_users_donate_to_charity charity_id
    GoalDonation.count(:user_id,:distinct => true, :conditions => ["charity_id = ? and current_stage_id = ? and user_id is not null", charity_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.how_many_logout_donation_to_charity charity_id
    GoalDonation.count(:id, :conditions => ["charity_id = ?  and current_stage_id = ? and user_id is null", charity_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.total_users_donated_to_achiever achiever_id
    GoalDonation.count(:user_id,:distinct => true, :joins => 'left outer join goals on goals.id = goal_donations.goal_id', :conditions => ["goals.achiever_id = ? and current_stage_id = ? and user_id is not null", achiever_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.total_logout_donation_to_achiever achiever_id
    GoalDonation.count(:id, :joins => 'left outer join goals on goals.id = goal_donations.goal_id', :conditions => ["goals.achiever_id = ? and current_stage_id = ? and user_id is null", achiever_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.total_raised_by_achiever user_id
     GoalDonation.sum(:amount, :joins => 'left outer join goals on goals.id = goal_donations.goal_id', :conditions => ["goals.achiever_id = ?  and current_stage_id = ? ", user_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.find_most_recent_donations_by_goal_id goal_id
    GoalDonation.where("goal_id = ? and current_stage_id = ?", goal_id, GoalDonationStage::APPROVED.id).order('id DESC').limit(5)
  end
  
  def self.find_approved_donations_between start_date, end_date
    GoalDonation.where("current_stage_id = ? and updated_at between ? and ?", GoalDonationStage::APPROVED.id, start_date, end_date)
  end
  
  def self.find_all_to_display_by_goal_id goal_id
    GoalDonation.where("goal_id = ? and current_stage_id = ?", goal_id, GoalDonationStage::APPROVED.id)
  end
  
  def self.find_most_recent_donations_by_charity_id charity_id
    GoalDonation.where("charity_id = ? and current_stage_id = ?", charity_id, GoalDonationStage::APPROVED.id).order('id DESC').limit(10)
  end
  
  def self.find_total_raised_amount_by_charity_id charity_id
    GoalDonation.sum(:amount, :conditions => ["charity_id = ? and current_stage_id = ?", charity_id, GoalDonationStage::APPROVED.id])
  end
  
  def self.find_all_between_dates_by_charity charity_id, from, to
    GoalDonation.where("charity_id = ? and current_stage_id = ? and created_at between ? and ?", charity_id, GoalDonationStage::APPROVED.id, from, to).order("id") 
  end
  
  def self.sum_donation_amount_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:amount, :conditions => ["charity_id = ? and current_stage_id = ? and created_at between ? and ?", charity_id, GoalDonationStage::APPROVED.id, from, to])
  end
  
  def self.sum_pagseguro_fees_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:pagseguro_fee, :conditions => ["charity_id = ? and current_stage_id = ? and created_at between ? and ?", charity_id, GoalDonationStage::APPROVED.id, from, to])
  end
  
  def self.sum_goalnect_fees_by_charity_between_dates charity_id, from, to
    GoalDonation.sum(:goalnect_fee, :conditions => ["charity_id = ? and current_stage_id = ? and created_at between ? and ?", charity_id, GoalDonationStage::APPROVED.id, from, to])
  end
  
  def self.is_there_donations_for_this_goal goal_id
     donation = GoalDonation.where("goal_id = ? and current_stage_id = ?", goal_id, GoalDonationStage::APPROVED.id).first
     return !donation.nil?
  end
  
  def to_s
    "GoalDonation => [id:#{self.id},amount:#{self.amount}, goal_id:#{self.goal_id}]"
  end
end
