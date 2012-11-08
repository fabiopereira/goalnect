require 'acceptance/acceptance_helper'

feature 'Mark finds Goalnect and decides to quit smoking', %q{
  In order for Mark to quit smoking he needed to see the benefit of helping 
  a charity along the journey
} do
  
  scenario 'Mark and his sudden decision to quit smoking' do  
    charity = ensure_charity_active_exists 'charitysmokingkills'
    # goal = discover_goalnect_and_decide_to_commit_to_goal_template 'mark', 'Quit Smoking', charity
  end

end
