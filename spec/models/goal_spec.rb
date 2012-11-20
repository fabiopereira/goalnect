require 'spec_helper'

describe Goal do
  
  it 'should only count approved goals when reporting how much has raised so far' do
    goal = FactoryGirl.create(:goal)
    
    donate_to goal, GoalDonationStage::APPROVED, 20
    donate_to goal, GoalDonationStage::APPROVED, 30
    donate_to goal, GoalDonationStage::PENDING, 10 
    
    goal.raised_so_far.should be == 50
  end
  
  it 'should find a goal template when creating a goal with the same title' do
    goal_template = FactoryGirl.create(:goal_template)
    goal = FactoryGirl.create(:goal)
    
    goal.goal_template.should be_nil
    goal.title_selected = goal_template.title
    
    goal.goal_template.should be == goal_template
    goal.title.should be == goal_template.title
    goal.title.should be == goal.title_selected
  end

  it 'should create a valid user' do
    FactoryGirl.create(:any_user)
    FactoryGirl.create(:any_user)
  end
  
  it 'should inform days left for a goal' do
    goal_in_10_days = FactoryGirl.create(:goal, due_on: 10.days.from_now)
    goal_in_10_days.days_left.should be == 10
    goal_in_10_days.due_today?.should be_false
    
    todays_goal = FactoryGirl.create(:goal, due_on: Date.today)
    todays_goal.days_left.should be == 1
    todays_goal.due_today?.should be_true
    
    todays_goal.due_on = 3.days.ago
    todays_goal.save
    todays_goal.days_left.should be == 0
  end
  
  def donate_to goal, stage, amount
    FactoryGirl.create(:goal_donation, 
        goal: goal, 
        current_stage_id: stage.id, 
        amount: amount
    )
  end
  
end