module SetLocale
  
  # http://guides.rubyonrails.org/i18n.html
  def set_locale
    I18n.locale = [
        set_locale_from_param,
        ENV['FIXED_LOCALE'], 
        set_locale_from_current_user,
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
  
end