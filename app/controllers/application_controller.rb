class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  # http://guides.rubyonrails.org/i18n.html
  def set_locale
    I18n.locale = [
        set_locale_from_current_user,
        set_locale_from_domain,
        set_locale_from_accept_language_http_header,
        set_locale_default
      ].find { |locale| locale != nil } 
      logger.debug "Setting locale to #{I18n.locale}"
  end  

  def set_locale_default
    I18n.default_locale
  end
  
  def set_locale_from_current_user
    current_user ? current_user.country.locale : nil
  end
  
  def set_locale_from_accept_language_http_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  
  # To test this locally, add to /etc/hosts 
  # 127.0.0.1 local.goalnect.com
  # 127.0.0.1 local.goalnect.com.au
  # 127.0.0.1 local.goalnect.com.br
  # 127.0.0.1 local.goalnect.org.br
  def set_locale_from_domain
    parsed_locale = request.host.split('.').last
    logger.debug "Getting locale from host #{request.host} parsed_locale #{parsed_locale}"
    parsed_locale = parsed_locale == "br" ? "pt" : parsed_locale
    logger.debug "Available locales #{I18n.available_locales}"
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
  
end
