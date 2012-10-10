require 'acceptance/support/user_steps'
module GoalSteps
  include UserSteps
	def commit_to_a_goal title
	  visit '/'
	  click_on 'New Goal'
	  fill_in 'goal_title', :with => title                                  
	  description = "Description for goal #{title}"
	  page.execute_script %Q{ $('#goal_description').data("wysihtml5").editor.setValue('#{description}') }
    # fill_in 'goal_description', :with => description
    # fill_in 'goal_due_on', :with => 2.months.from_now
	  click_on 'Create Goal'
	  page.should have_content 'Goal was successfully created'
	  Goal.find_by_title title
	end
	
	def visit_goal goal
	  user = goal.achiever
	  visit "/#{user.username}/goals/show/#{goal.id}"
	end
	
	def support_believing goal
	  visit_goal goal
	  page.should have_content goal.title
	  click_on 'I Believe'
	  page.should have_content 'believes: 1'
	end
	
	def donate_logged_in goal
	  visit_goal goal
    is_logged_in?.should == true
	  click_on 'Donate'
    page.should have_content "New goal_donation"
	  click_on 'Donate'
    page.should have_content "2 errors below"
    page.should have_content "Amount can't be blank"
    page.should have_content "Amount is not a number"
    message = "Message #{rand(1..1000)}"
    amount = rand(10..1000)
	  fill_in 'goal_donation_message', :with => message
	  fill_in 'goal_donation_amount', :with => amount
	  click_on 'Donate'
    page.should have_content "Goal donation was successfully created"
	  click_on 'PagSeguro'
    page.should have_content "Donation received, waiting for pagseguro to confirm"

    #assert that goal_donation was created successfully
    goal_donation = GoalDonation.find_by_message(message)
    goal_donation.amount.should be == amount
    #goal_donation.donor_name.should be == current_user.screen_name

	  visit_goal goal
    page.should have_content goal_donation.amount
    page.should have_content goal_donation.donor_name

	  GoalDonation.find_by_message(message)
	end
	
end

RSpec.configuration.include GoalSteps, :type => :acceptance
