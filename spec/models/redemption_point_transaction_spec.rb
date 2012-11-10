require 'spec_helper'

describe RedemptionPointTransaction do
  
  it 'should consolidate all active points for user into a single redemption transaction' do
    goal = Given.a :goal
    Given.an_approved_donation_for_goal goal, 70
    Given.an_approved_donation_for_goal goal, 30
    goal.raised_so_far.should == 100
    
    redemption = Given.a_redemption_for_user goal.achiever
    redemption.point_amount.should == 100
  end

end