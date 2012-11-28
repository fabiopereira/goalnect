require 'acceptance/acceptance_helper'

feature 'Charity reporting abuse for a goal', %q{
  A charity should be able to inactivated a goal, if it thinks goal is not appropriated.
} do
  
  scenario 'Report abuse' do  
    #Danni wants to lose weight and will sign up on Goalnect
    charity = ensure_charity_active_exists 'charityReportAbuse'
    
    danni = ensure_logged_in 'danni'
    
    dannis_goal = commit_to_a_goal 'This is a crap goal!', charity
    
    leo = ensure_logged_in 'leo'
    
    visit_charity_page_as_admin leo.username, charity.id
    click_on "Last 10 Goals"
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

  end

  

end
