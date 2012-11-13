class RedemptionPointTransaction < ActiveRecord::Base
  attr_accessible :cpf, :money_amount, :point_amount, :user_id, :processed
  
  validates_presence_of :cpf, :money_amount, :point_amount, :user_id
  
  after_save :redeem_transactions

  def user
    user_id ? User.find(user_id) : nil
  end
  
  def user=(user)
    self.user_id = user.id
    self.point_amount = user.points_summary.available_points
    self.money_amount = self.point_amount
    self.cpf = self.cpf ? self.cpf : user.cpf
    # goal_donation_transactions_to_be_redeemed = GoalDonationPointTransaction.find(:all, 
    #   :conditions => ["user_id = ? AND active = ? AND redemption_point_transaction_id is null", 
    #                    user_id, true])
    #                    
    # goal_donation_transactions_to_be_redeemed
    # write_attribute(:user_id, user.id)
  end         
  
  def redeem_transactions
    transactions_to_be_redeemed.each do |t|
      t.redemption_point_transaction_id = self.id
      t.save
    end
  end

  def transactions_to_be_redeemed
    GoalDonationPointTransaction.find(:all, :conditions => ['user_id = ? and active = ? and redemption_point_transaction_id is null', self.user.id, true])
  end

  def redeemed_transactions
    GoalDonationPointTransaction.find(:all, :conditions => ['redemption_point_transaction_id = ?', self.id])
  end
  
end
