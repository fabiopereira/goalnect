require 'acceptance/acceptance_helper'

feature 'Mark finds Goalnect and decides to quit smoking', %q{
  In order for Mark to quit smoking he needed to see the benefit of helping 
  a charity along the journey
} do
  
  scenario 'Mark and his sudden decision to quit smoking' do  
    charity = ensure_charity_active_exists 'charitysmokingkills'

    
    #goal_template = ensure_goal_template_exists 'Quit Smoking'
    #
    #visit_home_and_decide_to_commit_to_goal_template
    #mark = ensure_logged_in 'mark'
    #dannis_goal = commit_to_a_goal 'Lose 35kg', charity
    #
    #ensure_user_has_points_active 'danni', 0
    #ensure_user_has_points_locked 'danni', 0
    #
    ## Danni told her friend Leo about Goalnect and asked Leo to help her
    #leo = ensure_logged_in 'leo'
    #support_believing dannis_goal
    #donation_leo = donate_logged_in dannis_goal
    #donation_anonymous = donate_anonymously dannis_goal
    #
    ## Danni should have received 2 point transactions
    #total_points_locked = donation_leo.amount + donation_anonymous.amount
    #ensure_user_has_points_active danni.username, 0
    #ensure_user_has_points_locked danni.username, total_points_locked
    #
    ## Leo should have received points related to her donation only, and they're locked
    #ensure_user_has_points_active leo.username, 0
    #ensure_user_has_points_locked leo.username, donation_leo.amount
    #
    ##Once Danni finishes her goal, all points are unlocked
    #finish_goal dannis_goal
    #ensure_user_has_points_active danni.username, total_points_locked
    #ensure_user_has_points_locked danni.username, 0
    #ensure_user_has_points_active leo.username, donation_leo.amount
    #ensure_user_has_points_locked leo.username, 0
  end

end
