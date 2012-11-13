class UserPointSummary

   attr_reader :available_points, :blocked_points, :redeemed_points
  
  def initialize(user) 
    @available_points = GoalDonationPointTransaction.sum(:point_amount, 
       :conditions => ['user_id = ? and active = ? and redemption_point_transaction_id is null', 
         user.id, true])
    @blocked_points = GoalDonationPointTransaction.sum(:point_amount, 
       :conditions => ['user_id = ? and active = ? and redemption_point_transaction_id is null', 
         user.id, false])
    @redeemed_points = GoalDonationPointTransaction.sum(:point_amount, 
       :conditions => ['user_id = ? and redemption_point_transaction_id is not null', 
         user.id])
  end   
  
  def total
    @available_points +  @blocked_points + @redeemed_points
  end
  
end