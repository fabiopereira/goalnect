class RedemptionPointTransaction < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :cpf, :money_amount, :point_amount, :user_id, :processed
  
  validates_presence_of :money_amount, :point_amount, :user_id
  validates :point_amount, :numericality => { :greater_than => 0 }
  validates :money_amount, :numericality => { :greater_than => 0 }
  validates :cpf, :presence => true, :cpf => true
  
  belongs_to :user
  
  after_save :after_save_do
  
  def after_save_do              
    redeem_transactions             
    update_user_cpf
  end
  
  def update_user_cpf
    user.cpf = self.cpf
    user.save
  end

  def user
    user_id ? User.find(user_id) : nil
  end
  
  def user=(user)
    self.user_id = user.id
    self.point_amount = user.points_summary.available_points
    self.money_amount = self.point_amount
    self.cpf = self.cpf ? self.cpf : user.cpf
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
