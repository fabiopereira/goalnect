module UserSteps
  
  PASSWORD = '123456'  
  
  def logout_current_user
    if is_logged_in?
      click_on 'Logout'
    end
  end
  
  def user_is_logged_in? username
    is_logged_in? && find_username == username
  end        
  
  def is_logged_in?
    page.has_css?('#current_user_test')
  end
  
  def find_username
    page.find('#current_user_test').value
  end
  
  def login_user user
    login_user_password user.email, PASSWORD 
  end   
  
  def login_user_password email, password
    visit '/'   
    click_on 'Login'   
    login_user_password_already_in_login_page email, password     
  end    
  
  def ensure_username_exists username
    user = User.find_by_username(username)
    unless user
      user = FactoryGirl.create(:any_user, username: username)
    end
    user
  end

  def login_user_password_already_in_login_page email, password
    within("#sign_in") do
      fill_in 'user_email', :with => email
      fill_in 'user_password', :with => password
      click_on 'Sign in!'   
    end
  end  
  
  
  
  def user_should_be_prompted_for_sign_in_or_sign_up
    page.find('#sign_up').should_not be_nil
    page.find('#sign_in').should_not be_nil
  end
  
  def sign_up username
    user = FactoryGirl.build(:any_user, :username => username)   
    visit '/'   
    click_on 'Login'
    click_on 'Sign up'
    page.should have_content 'Sign up' 
    within("#sign_up") do
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => '123456'
      fill_in 'user_password_confirmation', :with => '123456'
      fill_in 'user_screen_name', :with => user.screen_name
      fill_in 'user_username', :with => user.username 
      click_on 'Sign up'   
    end
    user = User.find_by_username(user.username)
    # visit "/users/confirmation?confirmation_token=#{user.confirmation_token}" 
    page.should have_content user.screen_name      
    user = User.find_by_username(user.username)
  end
  
	def ensure_logged_out
	  logout_current_user          
	end
	
	def ensure_logged_in username          
	  user = find_current_user username
	  
	  if user_is_logged_in?(username)
	    visit '/'
	    return user
    end

    logout_current_user

	  if !user
	    user = sign_up username
    else 
      login_user user
	  end
	  
	  user
	end
	
	def visit_user_profile_by_username username
	  visit "/#{username}"
	end
	
	def find_current_user username
	  User.find_by_username(username)
	end
	
end

RSpec.configuration.include UserSteps, :type => :acceptance
