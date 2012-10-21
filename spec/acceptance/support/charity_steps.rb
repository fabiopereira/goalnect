require 'acceptance/support/user_steps'
module CharitySteps
  
  def ensure_charity_active_exists nickname
    
    # visit '/'
    #    login_user_password 'team@goalnect.com', '123456'
    
    visit '/charities/new'
    fill_in 'charity_charity_name', :with => nickname
    fill_in 'charity_contact_name', :with => 'contact'
    fill_in 'charity_email', :with => 'contact@test.com'
    fill_in 'charity_phone', :with => '2222222'
    click_on 'Send'
    

    charity = Charity.find_by_nickname(nickname) 
    charity.active = true
    charity.save!
    
    # visit "/admin/charities/#{charity.id.to_s}/edit"
    #    find(:css, "#charity_active").set(true)
    #    click_on 'Update Charity'
    #    
    #    charity = Charity.find_by_nickname(nickname) 
    puts 'charity => ' + charity.id.to_s  + charity.active.to_s
    charity
  end
  
end

RSpec.configuration.include CharitySteps, :type => :acceptance
