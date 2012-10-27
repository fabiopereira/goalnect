module DonationPaymentNotificationSteps
  def donation_payment_notification goal, goal_donation
	    uri = URI.parse(current_url)
      PagSeguro.config["base"] = "#{uri.scheme}://#{uri.host}:#{uri.port}"
  	  ENV["ID"] = goal_donation.id.to_s
  	  PagSeguro::Rake.run
      goal_donation = GoalDonation.find_by_message(goal_donation.message)
      goal_donation.current_status.should be == 'completed'

      visit_goal goal
      page.should have_content goal_donation.amount
      page.should have_content goal_donation.donor_name
      page.should have_css("span.icon44")
	end
end

RSpec.configuration.include DonationPaymentNotificationSteps, :type => :acceptance