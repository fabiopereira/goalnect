require 'spec_helper'

describe RedemptionPointTransaction do
  
  it 'should consolidate all active points for user into a single redemption transaction' do
    goal = Given.a :goal
    goal.achiever.cpf = Given.a_valid_cpf
    Given.an_approved_donation_for_goal goal, 70
    Given.an_approved_donation_for_goal goal, 30
    goal.raised_so_far.should == 100
                                             
    user = goal.achiever
    redemption = Given.a_redemption_for_user user
    redemption.point_amount.should == 100
    redemption.money_amount.should == 100
    redemption.cpf.should == user.cpf
  end
end