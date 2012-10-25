require 'acceptance/acceptance_helper'

feature 'Danni losing weight and friend leo helping', %q{
  In order for Danni to lose 35kg in 12 months she needs support from her friends
  As a Goalnect Achiever Danni needs to register her goal and ask friends 
  to support and believe that she can achieve it 
} do
  
  scenario 'Danni and her 12 months journey losing 35kg with friend Leo' do  
    #Danni wants to lose weight and will sign up on Goalnect
    charity = ensure_charity_active_exists 'charitytest'
    
    danni = ensure_logged_in 'danni'
    dannis_goal = commit_to_a_goal 'Lose 35kg', charity
    
    ensure_user_has_points_active 'danni', 0
    ensure_user_has_points_locked 'danni', 0
    
    # Danni told her friend Leo about Goalnect and asked Leo to help her
    leo = ensure_logged_in 'leo'
    support_believing dannis_goal
    donation_leo = donate_logged_in dannis_goal
    donation_anonymous = donate_anonymously dannis_goal
    
    # Danni should have received 2 point transactions 
    total_points_locked = donation_leo.amount + donation_anonymous.amount
    ensure_user_has_points_active 'danni', 0
    ensure_user_has_points_locked 'danni', total_points_locked
    
    # Leo should have received points related to her donation only, and they're locked 
    ensure_user_has_points_active 'leo', 0
    ensure_user_has_points_locked 'leo', donation_leo.amount
    
    #Once Danni finishes her goal, all points are unlocked
  end

end
