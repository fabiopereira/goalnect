class RedemptionPointTransaction < ActiveRecord::Base
  attr_accessible :cpf, :money_amount, :point_amount, :user_id, :processed
  
  validates_presence_of :cpf, :money_amount, :point_amount, :user_id

  def user
    user_id ? User.find(user_id) : nil
  end
  
  def user=(user)
    self.user_id = user.id
    self.point_amount = user.points_to_redeem
    self.money_amount = self.point_amount
    self.cpf = user.cpf
    # goal_donation_transactions_to_be_redeemed = GoalDonationPointTransaction.find(:all, 
    #   :conditions => ["user_id = ? AND active = ? AND redemption_point_transaction_id is null", 
    #                    user_id, true])
    #                    
    # goal_donation_transactions_to_be_redeemed
    
    # write_attribute(:user_id, user.id)
  end
  
end
