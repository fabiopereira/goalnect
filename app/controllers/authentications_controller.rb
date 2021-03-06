class AuthenticationsController < ApplicationController

def create
  auth = request.env["omniauth.auth"]
  puts 'auth["credentials"]["token"]' + auth["credentials"]["token"]
  session[:fb_token] = auth["credentials"]["token"] if auth['provider'] == 'facebook'
  
  # Try to find authentication first
  authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
 
  if authentication
    # Authentication found, sign the user in.    
    sign_in_and_redirect(:user, authentication.user)
  else
    user = User.find_by_email(auth['extra']['raw_info']['email'])
    if user.nil?
      # Authentication not found, thus a new user.
      user = User.new
    end
    user.apply_omniauth(auth)
    if user.save(:validate => false)                                   
      sign_in_and_redirect(:user, user)
    else                                        
      flash[:error] = t('errors.facebook_login_error')
      redirect_to root_url
    end
  end
end

def facebook_logout
    redirect_to "https://www.facebook.com/logout.php?confirm=1&next=#{facebook_logout_callback_url}&access_token=#{session[:fb_token]}";
end

end