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
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_on 'Sign in'   
    page.should have_content 'ABOUT ME'       
  end    
  
  def sign_up username
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
    page.select Country::AUSTRALIA.name, :from => 'user_country_id'
    click_on 'Sign up'   
    user = User.find_by_username(user.username)
    # visit "/users/confirmation?confirmation_token=#{user.confirmation_token}" 
    page.should have_content 'ABOUT ME'       
    user = User.find_by_username(user.username)
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
