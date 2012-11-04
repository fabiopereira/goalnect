require 'spec_helper'

describe Goal do
  
  it 'should only count approved goals when reporting how much has raised so far' do
    goal = FactoryGirl.create(:goal)
    
    donate_to goal, GoalDonationStage::APPROVED, 20
    donate_to goal, GoalDonationStage::APPROVED, 30
    donate_to goal, GoalDonationStage::PENDING, 10 
    
    goal.raised_so_far.should be == 50
  end

  it 'should create a valid user' do
    FactoryGirl.create(:any_user)
    FactoryGirl.create(:any_user)
  end
  
  def donate_to goal, stage, amount
    FactoryGirl.create(:goal_donation, goal: goal, current_stage_id: stage.id, amount: amount)
  end

end