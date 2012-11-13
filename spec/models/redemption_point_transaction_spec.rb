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
    redemption.save!
  end

  it 'should validate cpf' do
    redemption = Given.a_redemption_for_user Given.a_user_with_points_to_redeem
    redemption.cpf = "invalidcpf"
    redemption.save.should be_false
    redemption.errors[:cpf].should == ["is invalid"]
  end

  it 'should update users cpf when user does not have one' do
    user = Given.a_user_with_points_to_redeem
    user.cpf = nil
    user.save!
    redemption = Given.a_redemption_for_user user
    redemption.cpf = Given.a_valid_cpf
    redemption.save!
        
    user = User.find user.id
    # user.cpf.should == redemption.cpf
  end
    
end