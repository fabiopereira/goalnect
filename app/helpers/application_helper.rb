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
  

  # app/helpers/application_helper.rb
  def twitterized_type(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end  
  
end
