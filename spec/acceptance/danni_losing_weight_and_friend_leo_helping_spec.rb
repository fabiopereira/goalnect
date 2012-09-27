require 'acceptance/acceptance_helper'

feature 'Danni losing weight and friend leo helping', %q{
  In order for Danni to lose 35kg in 12 months she needs support from her friends
  As a Goalnect Achiever Danni needs to register her goal and ask friends to support and believe that she can achieve it 
} do

  scenario 'Danni 12 months journey losing 35kg' do
    # danni = FactoryGirl.attributes_for(:any_user)
    
    danni = {
      'email' => 'danni@goalnect.com',
      'password' => '123456',
      'screen_name' => 'Danni',
      'username' => 'danni'
    }
    
    # puts 'Dannis email - ' + danni['email']
    
    visit '/'
    click_on 'Login'
    page.should have_content 'Sign in'            
    
    
    fill_in "user_email",    :with => danni['email']
    fill_in 'user_password', :with => danni['password']
    click_on 'Sign in'
    page.should have_content 'Invalid email or password'
    
    click_on 'Sign up'
    page.should have_content 'Sign up'
    
    click_on 'Sign up'
    page.should have_content 'errors'
    
    fill_in 'user_email', :with => danni['email']
    fill_in 'user_password', :with => danni['password']
    fill_in 'user_password_confirmation', :with => danni['password']
    fill_in 'user_screen_name', :with => danni['screen_name'] 
    fill_in 'user_username', :with => danni['username'] 
    # fill_in 'user_dob', :with => danni['dob'].strftime("%d/%m/%Y") 
    fill_in 'dob', :with => 27.years.ago.strftime("%d/%m/%Y") 
    
    # click_on 'Sign up'
    # 
    # page.should have_content 'confirmation link has been sent to your email'
    
  end

end
