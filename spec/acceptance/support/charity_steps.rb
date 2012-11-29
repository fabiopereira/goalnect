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
    charity.pagseguro_email = 'pagseguro@charity.com.br'
    charity.save!
    charity
  end
  
  def set_user_as_charity_admin user, charity_id
    user.charity_id = charity_id
    user.save!
  end
  
  def visit_charity_page charity
    visit "/charities/#{charity.id}"
    page.should have_content user.charity.charity_name
  end
  
  def visit_charity_page_as_admin username, charity_id
    user = ensure_logged_in username
    set_user_as_charity_admin user, charity_id
    visit '/'
    click_on user.charity.charity_name
    sleep 10
    page.should have_content user.charity.charity_name
    
  end
  
  def ensure_charity_has_raised_so_far_amount amount
    find('#raised_so_far').should have_content(amount)
  end
  
  def visit_all_donations_page_verify_summaries gross_amount, pagseguro_fee, goalnect_fee, net_amount
    
    click_on "List All Donations"
    find("#previous_donations_amount").should have_content("0.0")
    find("#previous_total_pagseguro_fee").should have_content("0.0")
    find("#previous_total_goalnect_fee").should have_content("0.0")
    find("#previous_net_donations_amount").should have_content("0.0")
    page.should have_content "Previous month donations transactions (PDF)"
    
    click_on "Current Month"
    find("#current_donations_amount").should have_content(gross_amount)
    find("#current_total_pagseguro_fee").should have_content(pagseguro_fee)
    find("#current_total_goalnect_fee").should have_content(goalnect_fee)
    find("#current_net_donations_amount").should have_content(net_amount)
    page.should have_content "Current Donations Transactions (PDF)"
    
  end
  
  
  
end

RSpec.configuration.include CharitySteps, :type => :acceptance
