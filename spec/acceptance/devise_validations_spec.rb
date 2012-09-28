require 'acceptance/acceptance_helper'

feature 'User sign up and sign in validations', %q{
  In order a user to sign up and sign in correctly we need validations
} do
  
  scenario 'Attempt sign up and sign in causing errors' do  
            # visit '/' 
            # click_on 'Login'
            # page.should have_content 'Sign in'            
            # 
            # fill_in "user_email",    :with => danni['email']
            # fill_in 'user_password', :with => danni['password']
            # click_on 'Sign in'
            # page.should have_content 'Invalid email or password'
            # 
            # click_on 'Sign up'
            # page.should have_content 'Sign up'
            # 
            # click_on 'Sign up'
            # page.should have_content 'errors'
            # 
            # fill_in 'user_email', :with => danni['email']
            # fill_in 'user_password', :with => danni['password']
            # fill_in 'user_password_confirmation', :with => danni['password']
            # fill_in 'user_screen_name', :with => danni['screen_name'] 
            # fill_in 'user_username', :with => danni['username'] 
            # # fill_in 'user_dob', :with => danni['dob'].strftime("%d/%m/%Y") 
            # fill_in 'dob', :with => 27.years.ago.strftime("%d/%m/%Y") 
            # 
            # click_on 'Sign up'
            # 
            # page.should have_content 'confirmation link has been sent to your email'
            #         
            # visit '/' + danni['username']
            # page.should have_content 'You need to sign in or sign up before continuing'
            # 
            # fill_in "user_email",    :with => danni['email']
            # fill_in 'user_password', :with => danni['password']
            # click_on 'Sign in'
            # page.should have_content 'You have to confirm your account before continuing'
            # 
            # user = User.find_by_username(danni['username'])
            # visit '/users/confirmation?confirmation_token=' + user.confirmation_token
            # 
            # page.should have_content 'ABOUT ME' 
  end

end
