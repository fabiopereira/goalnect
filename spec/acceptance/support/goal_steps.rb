require 'acceptance/support/user_steps'
require 'acceptance/support/donation_payment_notification'

module GoalSteps
  include UserSteps, DonationPaymentNotificationSteps

	def visit_goal goal
	  user = goal.achiever
	  visit "/#{user.username}/goals/show/#{goal.id}"
	end
	
  def finish_goal goal
    ensure_logged_in goal.achiever.username
    visit_goal goal
    click_on 'Journey'
    sleep 2
    page.select "done", :from => "goal_feedback_goal_stage_id"

    # Should validate that message is mandatory when changing goal stage    
    click_on "Send"
    page.should have_content "Message can't be blank"
    
    page.execute_script %Q{ $('#goal_feedback_message').data("wysihtml5").editor.setValue('I made it, yay') }
    click_on "Send"
    
    page.should_not have_css("#goal_feedback_goal_stage_id")
  end
  
	def commit_to_a_goal title, charity
	  visit '/'
	  click_on 'New Goal'
	  fill_in 'goal_title_selected', :with => title                                  
	  description = "Description for goal #{title}"
	  page.execute_script %Q{ $('#goal_description').data("wysihtml5").editor.setValue('#{description}') }
    # fill_in 'goal_description', :with => description
    # fill_in 'goal_due_on', :with => 2.months.from_now
    page.select charity.charity_name, :from => 'goal_charity_id'
    fill_in 'goal_target_amount', :with => 100
	  click_on 'Create Goal'
	  page.should have_content 'Goal was successfully created'
	  Goal.find_by_title title
	end
	
	def support_believing goal
	  visit_goal goal
	  page.should have_content goal.title
	  click_on 'i_believe_button'
	  page.should have_content 'Possible: 1'
	end
	
	def donate_logged_in goal
	  visit_goal goal
    is_logged_in?.should == true
    username= find_username
    current_user = find_current_user username
	  click_on 'donate_button'
    page.should have_content "New donation"
	  click_on 'donate_button'
    page.should have_content "Amount can't be blank"
    page.should have_content "Amount is not a number"
    message = "Message #{rand(1..1000)}"
    amount = rand(10..1000)
	  fill_in 'goal_donation_message', :with => message
	  fill_in 'goal_donation_amount', :with => amount
	  click_on 'donate_button'
    page.should have_content "Donation Confirmation"
    find(:xpath, '//form[@class="pagseguro"]/div/input[@type="submit"]').click
	  page.should have_content "Donation received, waiting for pagseguro to confirm"
    
    #assert that goal_donation was created successfully
    goal_donation = GoalDonation.find_by_message(message)
    goal_donation.amount.should be == amount
    goal_donation.donor_name.should be == current_user.screen_name
    visit_goal goal
    page.should have_content goal_donation.amount
    page.should have_content goal_donation.donor_name
    # represents waiting_for_notification status
    page.should have_css("span.icon110")
    
	  goal_donation = GoalDonation.find_by_message(message)
	  
	  donation_payment_notification goal, goal_donation

    GoalDonation.find_by_message(message)
	end
	
	def donate_anonymously goal
	  logout_current_user
	  fill_in 'q', :with => goal.achiever.username
	  click_on 'Search'
	  click_on goal.achiever.screen_name
	  click_on goal.title
	  click_on 'donate_button' 
	  page.should have_content "New donation"
	  click_on 'donate_button'
    page.should have_content "Donor name can't be blank"
	  donor_name = "Anonymous #{rand(1..1000)}"
    amount = rand(10..1000)
    message = "message bla! #{rand(1..1000)}"
    fill_in 'goal_donation_donor_name' , :with => donor_name
	  fill_in 'goal_donation_message', :with => message
	  fill_in 'goal_donation_amount', :with => amount
	  click_on 'donate_button'
    page.should have_content "Donation Confirmation"
    find(:xpath, '//form[@class="pagseguro"]/div/input[@type="submit"]').click
  	page.should have_content "Donation received, waiting for pagseguro to confirm"
  
  
    #assert that goal_donation was created successfully
    goal_donation = GoalDonation.find_by_message(message)
    goal_donation.amount.should be == amount
    goal_donation.donor_name.should be == donor_name
    goal_donation.message.should be == message
    goal_donation.user_id.should be_nil
    goal_donation.current_stage.should be == GoalDonationStage::WAITING_NOTIFICATION
    
   donation_payment_notification goal, goal_donation
    
   GoalDonation.find_by_message(message)
	end
	
	
	
end

RSpec.configuration.include GoalSteps, :type => :acceptance
