require 'acceptance/acceptance_helper'

feature 'Anne finds Goalnect and decides to quit smoking', %q{
  In order for Anne to quit smoking he needed to see the benefit of helping 
  a charity along the journey
} do
  
  scenario 'Anne and her sudden decision to quit smoking' do  
    charity = ensure_charity_active_exists 'charitysmokingkills'
    goal = discover_goalnect_and_decide_to_commit_to_goal_template 'anne', 'Quit Smoking', charity
    
    non_registered_user_explores_goals
    non_registered_user_explores_goal_template goal.goal_template
  end

end
