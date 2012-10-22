require 'acceptance/support/user_steps'
module CharitySteps
  
  def ensure_charity_active_exists nickname
    visit '/charities/new'
    fill_in 'charity_charity_name', :with => nickname
    fill_in 'charity_contact_name', :with => 'contact'
    fill_in 'charity_email', :with => 'contact@test.com'
    fill_in 'charity_phone', :with => '2222222'
    click_on 'Send'
    charity = Charity.find_by_nickname(nickname) 
    charity.active = true
    charity.save!
    charity
  end
  
end

RSpec.configuration.include CharitySteps, :type => :acceptance
