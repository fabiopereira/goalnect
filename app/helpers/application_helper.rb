module ApplicationHelper
  def sign_in_and_redirect_to_current
    '/users/sign_in?user_return_to=' + request.path
  end
  
  def current_url
    if Rails.env.development? or Rails.env.test?
      'http://' + request.host + ':' + request.port.to_s + request.fullpath
    else
      'http://' + request.host + request.fullpath
    end
  end
  
end
