module UserSteps
  
  PASSWORD = '123456'
  
  def is_logged_in username
    page.has_css?('#current_user_username') && page.find('#current_user_username').text == username
  end
  
	def logged_in username          
	  user = User.find_by_username(username)
	  
	  if is_logged_in(username)
	    visit '/'
	    return user
    end

    if page.has_css?('#current_user_username')
      click_on 'Logout'
    end

	  if !user
      user = FactoryGirl.build(:any_user, :username => username)   
      visit '/'   
      click_on 'Login'
      click_on 'Sign up'
      page.should have_content 'Sign up' 
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => '123456'
      fill_in 'user_password_confirmation', :with => '123456'
      fill_in 'user_screen_name', :with => user.screen_name
      fill_in 'user_username', :with => user.username 
      fill_in 'dob', :with => user.dob.strftime("%d/%m/%Y")
      click_on 'Sign up'   
      user = User.find_by_username(user.username)
      visit "/users/confirmation?confirmation_token=#{user.confirmation_token}" 
      page.should have_content 'ABOUT ME'       
      user = User.find_by_username(user.username)
    else 
      visit '/'   
      click_on 'Sign in'   
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => PASSWORD
      click_on 'Sign in'   
      page.should have_content 'ABOUT ME'       
	  end
	  
	  user
	end
end

RSpec.configuration.include UserSteps, :type => :acceptance
