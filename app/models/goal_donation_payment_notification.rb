class GoalDonationPaymentNotification < ActiveRecord::Base
  attr_accessible :currency, :donor_email, :donor_name, :fees, :goal_donation_id, :payment_channel, :payment_method, :price, :processed_at, :transaction_id, :goal_donation
  attr_accessible :status, :stage_id

  belongs_to :goal_donation, :class_name => 'GoalDonation', :foreign_key => 'goal_donation_id'
end
