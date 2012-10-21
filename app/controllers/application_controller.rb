# encoding: UTF-8
class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :set_user_return_to
  before_filter :set_locale
  skip_before_filter :verify_authenticity_token
  
  def authenticate_admin_user!
    authenticate_user! 
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to root_path 
    end
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end
  
  def set_user_return_to
    if params["user_return_to"] && params["user_return_to"].start_with?("/")
      session['user_return_to'] = params["user_return_to"]
    end
  end

  # http://guides.rubyonrails.org/i18n.html
  def set_locale
    I18n.locale = [
        set_locale_from_param,
        set_locale_from_current_user,
        set_locale_from_domain,
        set_locale_from_accept_language_http_header,
        set_locale_default
      ].find { |locale| locale != nil } 
      Goalog.debug "Setting locale to #{I18n.locale}"
  end  

  def set_locale_default
    I18n.default_locale
  end
  
  def set_locale_from_param
    locale_param = params[:locale]
    available_locales_as_s = I18n.available_locales.map { |x| x.to_s }
    if locale_param && !available_locales_as_s.include?(locale_param)
      raise "Invalid locale parameter #{locale_param}"
    end
    locale_param
  end
  
  def set_locale_from_current_user
    if (defined? current_user)
      current_user && current_user.country ? current_user.country.locale : nil
    else
      nil
    end
  end
  
  def set_locale_from_accept_language_http_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    locale_from_accept_language = accept_language ? accept_language.scan(/^[a-z]{2}/).first : nil
    Goalog.debug "locale accept_language #{accept_language}"
    Goalog.debug "locale_from_accept_language #{accept_language} is #{locale_from_accept_language}"
    locale_from_accept_language
  end
  
  # To test this locally, add to /etc/hosts 
  # 127.0.0.1 local.goalnect.com
  # 127.0.0.1 local.goalnect.com.au
  # 127.0.0.1 local.goalnect.com.br
  # 127.0.0.1 local.goalnect.org.br
  def set_locale_from_domain
    parsed_locale = request.host.split('.').last
    parsed_locale = parsed_locale == "br" ? "pt" : parsed_locale
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
  
  
  def remover_acentos(texto)
    return texto if texto.blank?
    texto = texto.gsub(/(á|à|ã|â|ä)/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    texto = texto.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    puts texto
    texto
  end
  
end
