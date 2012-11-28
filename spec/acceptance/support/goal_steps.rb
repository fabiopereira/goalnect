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
	  select_description "Description for goal #{title}"
    # fill_in 'goal_description', :with => description
    # fill_in 'goal_due_on', :with => 2.months.from_now
    commit_to_charity_and_target_amount charity
	  Goal.find_by_title title
	end
	
	def select_description description
	  page.execute_script %Q{ $('#goal_description').data("wysihtml5").editor.setValue('#{description}') }
	  description
	end
	
	def commit_to_charity_and_target_amount charity
	  click_on 'Create Goal'
	  page.should have_content "Charity can't be blank"
    page.should have_content "Target amount can't be blank"
    page.should have_content "Target amount is not a number"
    
	  page.select charity.charity_name, :from => 'goal_charity_id'
    fill_in 'goal_target_amount', :with => 5
	  click_on 'Create Goal'
	  
	  page.should have_content "Target amount must be greater than or equal to 50"
	  fill_in 'goal_target_amount', :with => 100
	  click_on 'Create Goal'
	  
	  page.should have_content 'Goal was successfully created'
	end
	
	def commit_to_a_goal_template charity, goal_template
	  description = select_description "Description for goal template #{goal_template.title} for charity #{charity.id}"
	  commit_to_charity_and_target_amount charity
	  Goal.find_by_title_and_description goal_template.title, description
	end
	
	def support_believing goal
	  visit_goal goal
	  page.should have_content goal.title
	  find('#i_support_true_button').click
	  find('#i_support_count_true').should have_content '1'
	  find('#i_support_true_button')['title'].should have_content 'including you'
	end
	
	def donate_logged_in goal, amount_donated
	  visit_goal goal
    is_logged_in?.should == true
    username= find_username
    current_user = find_current_user username
	  click_on 'donate_button'
    page.should have_content "Supporting"
	  click_on 'donate_button'
    page.should have_content "Amount can't be blank"
    page.should have_content "Amount is not a number"
    message = "Message #{rand(1..1000)}"
    amount = amount_donated ?  amount_donated : rand(10..1000)
	  fill_in 'goal_donation_message', :with => message
	  fill_in 'goal_donation_amount', :with => amount
	  click_on 'donate_button'
	  
	  #assert that goal_donation was created successfully
    goal_donation = GoalDonation.find_by_message(message)
    goal_donation.amount.should be == amount
    goal_donation.donor_name.should be == current_user.screen_name
    
    page.should have_content "Donation Confirmation"
    verify_donation_values goal, goal_donation
    find(:xpath, '//form[@class="pagseguro"]/div/input[@type="submit"]').click
    
    visit_goal goal

	  goal_donation = GoalDonation.find_by_message(message)
	  
	  donation_payment_notification goal, goal_donation

    GoalDonation.find_by_message(message)
	end
	
	def verify_donation_values goal, goal_donation

	 check_element_value "email_cobranca", goal.charity.pagseguro_email
	 check_element_value "moeda", "BRL"
	 check_element_value "ref_transacao", goal_donation.id.to_s
	 check_element_value "item_quant_1", 1.to_s
	 check_element_value "item_id_1", goal.charity.id.to_s
	 check_element_value "item_descr_1", "Donation to #{goal.charity.charity_name}"
	 amount_in_cents = goal_donation.amount * 100
	 check_element_value "item_valor_1", amount_in_cents.to_s
	 
	 
	end
	
	def check_element_value id, expected_value
	  find(:xpath, "//input[@id='#{id}']").value.should have_content expected_value
  end
	
	
	
	def donate_anonymously goal, amount_donated
	  logout_current_user
	  fill_in 'q', :with => goal.achiever.username
	  click_on 'Search'
	  click_on goal.achiever.screen_name
	  click_on goal.title
	  click_on 'donate_button' 
	  page.should have_content "Supporting"
	  click_on 'donate_button'
    page.should have_content "Donor name can't be blank"
	  donor_name = "Anonymous #{rand(1..1000)}"
    amount = amount_donated ?  amount_donated : rand(10..1000)
    message = "message bla! #{rand(1..1000)}"
    fill_in 'goal_donation_donor_name' , :with => donor_name
	  fill_in 'goal_donation_message', :with => message
	  fill_in 'goal_donation_amount', :with => amount
	  click_on 'donate_button'
    page.should have_content "Donation Confirmation"
    find(:xpath, '//form[@class="pagseguro"]/div/input[@type="submit"]').click
  
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
