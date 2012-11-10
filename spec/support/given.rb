class Given
  
  def self.a_redemption_for_user user
    redemption = RedemptionPointTransaction.new
    redemption.user = user
    redemption
  end
  
  def self.a factory_symbol
    FactoryGirl.create(factory_symbol)
  end
  
  def self.an_approved_donation_for_goal goal, amount
    goal_donation = FactoryGirl.create(:goal_donation, 
        goal: goal, 
        current_stage_id: GoalDonationStage::APPROVED.id, 
        amount: amount
    )
    FactoryGirl.create(:goal_donation_point_transaction, 
       goal_donation: goal_donation,
       point_amount: amount
    )
  end
  
  def self.a_goal_with_approved_donation_of amount
    goal = FactoryGirl.create(:goal)
    an_approved_donation_for_goal goal, amount
    goal.raised_so_far.should == amount
    goal
  end 
  
end
