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
    
    ensure_user_has_points :available,   'danni', 0
    ensure_user_has_points :locked,   'danni', 0
    ensure_user_has_points :redeemed, 'danni', 0
    
    # Danni told her friend Leo about Goalnect and asked Leo to help her
    leo = ensure_logged_in 'leo'
    support_believing dannis_goal
    donation_leo = donate_logged_in dannis_goal, 50
    donation_anonymous = donate_anonymously dannis_goal, 15
    
    # Danni should have received 2 point transactions 
    sum_of_donations = donation_leo.amount + donation_anonymous.amount
    ensure_user_has_points :available, danni.username, 0
    ensure_user_has_points :locked, danni.username, sum_of_donations
    ensure_user_has_points :redeemed, danni.username, 0
    
    # Leo should have received points related to her donation only, and they're locked 
    ensure_user_has_points :available, leo.username, 0
    ensure_user_has_points :locked, leo.username, donation_leo.amount
    ensure_user_has_points :redeemed, leo.username, 0
    
    #Once Danni finishes her goal, all points are unlocked
    finish_goal dannis_goal   
    visit '/'
    page.should have_content "2 backers"
    page.should have_content "$ 65 raised"
    page.should have_content "65 points"
    
    #     ensure_user_has_points :available, danni.username, sum_of_donations
    #     ensure_user_has_points :locked, danni.username, 0
    #     ensure_user_has_points :redeemed, danni.username, 0
    #     ensure_user_has_points :available, leo.username, donation_leo.amount
    #     ensure_user_has_points :locked, leo.username, 0
    #     ensure_user_has_points :redeemed, leo.username, 0
    #     
    #     #Danni decides to redeem her points
    #     cpf = redeem_points danni.username, sum_of_donations
    #     ensure_user_has_points :available, danni.username, 0
    #     ensure_user_has_points :locked, danni.username, 0
    #     ensure_user_has_points :redeemed, danni.username, sum_of_donations
    #     
    #     #Generate vantagens file
    #     generate_vantagens_file cpf, sum_of_donations
    
    #verify charity page
    visit_charity_page_as_admin danni.username, charity.id
    page.should have_content dannis_goal.title
    ensure_charity_has_raised_so_far_amount "65"
    page.should have_content "65 raised"
    page.should have_content "with donations from 2 people"
    page.should have_content "through 1 goals"
    
    GoalDonation.update_all(['pagseguro_fee = ?', 0.40], ['charity_id = ?',charity.id])   
    visit_all_donations_page_verify_summaries "65", "0.80", "4.88", "59.32"
end


end
