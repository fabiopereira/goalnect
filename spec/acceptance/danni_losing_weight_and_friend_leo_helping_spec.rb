require 'acceptance/acceptance_helper'

feature 'Danni losing weight and friend leo helping', %q{
  In order for Danni to lose 35kg in 12 months she needs support from her friends
  As a Goalnect Achiever Danni needs to register her goal and ask friends 
  to support and believe that she can achieve it 
} do
  
  scenario 'Danni and her 12 months journey losing 35kg with friend Leo' do  
    #Danni wants to lose weight and will sign up on Goalnect
    #charity = ensure_charity_active_exists 
    
    nickname = 'charitytest'
    
    
    
    visit '/charities/new'
    fill_in 'charity_charity_name', :with => nickname
    fill_in 'charity_contact_name', :with => 'contact'
    fill_in 'charity_email', :with => 'contact@test.com'
    fill_in 'charity_phone', :with => '2222222'
    click_on 'Send'
    

    charity = Charity.find_by_nickname(nickname) 
    charity.active = true
    # begin
      # Charity.transaction do
        charity.save!
        Charity.connection.execute("COMMIT") 
    #   end
    # rescue ActiveRecord::RecordInvalid => invalid
    #   # do whatever you wish to warn the user, or log something
    # end
    
    
    danni = ensure_logged_in 'danni'
    dannis_goal = commit_to_a_goal 'Lose 35kg', charity
    
    # Danni told her friend Leo about Goalnect and asked Leo to help her
    leo = ensure_logged_in 'leo'
    support_believing dannis_goal
    donate_logged_in dannis_goal
    donate_anonymously dannis_goal
    
  end

end
