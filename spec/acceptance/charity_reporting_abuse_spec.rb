require 'acceptance/acceptance_helper'

feature 'Charity reporting abuse for a goal', %q{
  A charity should be able to inactivated a goal, if it thinks goal is not appropriated.
} do
  
  scenario 'Report abuse' do  
    #Danni wants to lose weight and will sign up on Goalnect
    charity = ensure_charity_active_exists 'charitytest'
    
    danni = ensure_logged_in 'danni'
    
    dannis_goal = commit_to_a_goal 'This is a crap goal!', charity
    
    leo = ensure_logged_in 'leo'
    
    visit_charity_page_as_admin leo.username, charity.id
    
    find("#report_goal_#{dannis_goal.id}").click
    page.driver.browser.switch_to.alert.accept
    
    page.should have_content "This goal was reported, it will no longer be available."
    
    visit "/#{danni.username}/goals/show/#{dannis_goal.id}"
    page.should have_content "Goal is inactive, it has been reported by the charity"
    #verify is it has been redirected to leo's homepage
    page.should have_content leo.screen_name
    
    danni = ensure_logged_in 'danni'
    page.should_not have_content dannis_goal.title
    visit "/#{danni.username}/goals/show/#{dannis_goal.id}"
    page.should have_content "Goal is inactive, it has been reported by the charity"
    
    dannis_goal1 = commit_to_a_goal 'This is a crap goal 1!', charity
    dannis_goal2 = commit_to_a_goal 'This is a crap goal 2!', charity
    dannis_goal3 = commit_to_a_goal 'This is a crap goal 3!', charity
    dannis_goal4 = commit_to_a_goal 'This is a crap goal 4!', charity
    dannis_goal5 = commit_to_a_goal 'This is a crap goal 5!', charity
    dannis_goal6 = commit_to_a_goal 'This is a crap goal 6!', charity
    dannis_goal7 = commit_to_a_goal 'This is a crap goal 7!', charity
    dannis_goal8 = commit_to_a_goal 'This is a crap goal 8!', charity
    dannis_goal9 = commit_to_a_goal 'This is a crap goal 9!', charity
    dannis_goal10 = commit_to_a_goal 'This is a crap goal 10!', charity
    dannis_goal11 = commit_to_a_goal 'This is a crap goal 11!', charity
    
  end

  scenario 'Show all goal for charity' do  
    #Danni wants to lose weight and will sign up on Goalnect
    charity = ensure_charity_active_exists 'charitytest'
    
    danni = ensure_logged_in 'danni'
    dannis_goal1 = commit_to_a_goal 'This is a crap goal 1!', charity
    dannis_goal2 = commit_to_a_goal 'This is a crap goal 2!', charity
    dannis_goal3 = commit_to_a_goal 'This is a crap goal 3!', charity
    dannis_goal4 = commit_to_a_goal 'This is a crap goal 4!', charity
    dannis_goal5 = commit_to_a_goal 'This is a crap goal 5!', charity
    dannis_goal6 = commit_to_a_goal 'This is a crap goal 6!', charity
    dannis_goal7 = commit_to_a_goal 'This is a crap goal 7!', charity
    dannis_goal8 = commit_to_a_goal 'This is a crap goal 8!', charity
    dannis_goal9 = commit_to_a_goal 'This is a crap goal 9!', charity
    dannis_goal10 = commit_to_a_goal 'This is a crap goal 10!', charity
    dannis_goal11 = commit_to_a_goal 'This is a crap goal 11!', charity
    
    leo = ensure_logged_in 'leo'
    
    visit_charity_page_as_admin leo.username, charity.id
    
    page.should have_content dannis_goal1.title
    page.should have_content dannis_goal2.title
    page.should have_content dannis_goal3.title
    page.should have_content dannis_goal4.title
    page.should have_content dannis_goal5.title
    page.should have_content dannis_goal6.title
    page.should have_content dannis_goal7.title
    page.should have_content dannis_goal8.title
    page.should have_content dannis_goal9.title
    page.should have_content dannis_goal10.title
    page.should_not have_content dannis_goal11.title
    
    find('#charity_list_all_goals_id').click
    
    page.should have_content dannis_goal1.title
    page.should have_content dannis_goal2.title
    page.should have_content dannis_goal3.title
    page.should have_content dannis_goal4.title
    page.should have_content dannis_goal5.title
    page.should have_content dannis_goal6.title
    page.should have_content dannis_goal7.title
    page.should have_content dannis_goal8.title
    page.should have_content dannis_goal9.title
    page.should have_content dannis_goal10.title
    page.should have_content dannis_goal11.title
    

  end
  

end
