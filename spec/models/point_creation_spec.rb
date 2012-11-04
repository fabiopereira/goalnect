require 'spec_helper'

describe "how points are created" do
  
  it 'should create a point transaction when completing a goal donation' do
    goal_donation = FactoryGirl.create(:goal_donation, current_stage_id: GoalDonationStage::WAITING_NOTIFICATION.id)
    point_transactions_for(goal_donation).should be_empty
    goal_donation.current_stage_id = GoalDonationStage::APPROVED.id
    goal_donation.save
                                                                         
    point_transactions = point_transactions_for(goal_donation)
    point_transactions.should have(2).items
    
    donor_point_transaction = point_transactions.find { |t| t.user_id == goal_donation.user_id }     
    achiever_point_transaction = point_transactions.find { |t| t.user_id == goal_donation.goal.achiever_id }     
     
    donor_point_transaction.should_not be_nil
    achiever_point_transaction.should_not be_nil
    
    donor_point_transaction.point_amount.should eql(goal_donation.amount)
    donor_point_transaction.active.should be_false
    
    achiever_point_transaction.point_amount.should eql(goal_donation.amount)
    achiever_point_transaction.active.should be_false
    
    goal_donation.processed.should be_true

    # Should only create transaction once    
    goal_donation.current_stage_id = GoalDonationStage::APPROVED.id
    goal_donation.save
    point_transactions_for(goal_donation).should have(2).items
  end
  
  def point_transactions_for goal_donation
    GoalDonationPointTransaction.find_all_by_goal_donation_id(goal_donation.id)
  end
  
end