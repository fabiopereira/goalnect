class Given
  
  def self.a_redemption_for_user user
    redemption = RedemptionPointTransaction.new
    redemption.user = user
    redemption
  end
  
  def self.a_valid_cpf
    "12312312387"
  end            
  
  
  def self.a_user_with_points_to_redeem
    goal = Given.a :goal
    Given.an_approved_donation_for_goal goal, Random.rand(50..500)
    goal.achiever
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
    goal_donation
  end
  
  def self.a_goal_with_approved_donation_of amount
    goal = FactoryGirl.create(:goal)
    an_approved_donation_for_goal goal, amount
    goal.raised_so_far.should == amount
    goal
  end 
  
end
