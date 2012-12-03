# encoding: UTF-8
class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :set_user_return_to
  before_filter :set_locale
  skip_before_filter :verify_authenticity_token
  around_filter :user_time_zone, if: :current_user
  
  include CharitiesHelper
  
  def user_time_zone(&block)
    Time.use_zone(current_user.country.time_zone, &block)
  end
  
  def authenticate_admin_user!
    authenticate_user! 
    unless current_user.admin?
      flash[:alert] = t('alerts.area_restricted_to_admin')
      redirect_to root_path 
    end
  end
  
  def charity_admin_user!
    charity_id = params[:charity_id] ? params[:charity_id]  : params[:id]
    unless current_user && (current_user.admin? || is_current_user_charity_admin?(charity_id))
      flash[:alert] = t('alerts.area_restricted_to_charity_admin')
      redirect_to root_path 
    end
  end
  
  def charity_updates_admin_user!
     unless current_user && (current_user.admin? || is_current_user_charity_update_admin?)
        flash[:alert] =  t('alerts.area_restricted_to_charity_admin')
        redirect_to root_path 
      end
  end
  
  def goal_show!
    if !(is_current_user_achiever? || is_goal_active?)
      flash[:alert] = t('alerts.goal_is_not_active')
      if params[:user_username]
        redirect_to "/#{params[:user_username]}"
      else
        redirect_to root_path
      end
    end
  end
  
  def is_goal_active!
    if !is_goal_active?
      flash[:alert] = t('alerts.goal_is_not_active')   
       if params[:user_username] && params[:goal_id]
          redirect_to "/#{params[:user_username]}/goals/show/#{params[:goal_id]}"
        else
          redirect_to root_path
        end
    end
  end
  
  def is_goal_donation_waiting_notification
    goal_donation = GoalDonation.find(params[:id])                                
    if goal_donation.current_stage_id  !=  GoalDonationStage::WAITING_NOTIFICATION.id   
       flash[:alert] = t("alerts.donation_sent_to_pagseguro")
      redirect_to root_path
    end
  end
  
  def is_current_user_achiever
    if !is_current_user_achiever?
      flash[:alert] = t("alerts.area_restricted_to_achiever")
      if params[:user_username]
        redirect_to "/#{params[:user_username]}"
      else
        redirect_to root_path
      end
    end
  end
  
  def is_current_user_achiever?
    if (params[:goal_id] || params[:id])
      id = params[:goal_id] ? params[:goal_id] : params[:id]
      goal = Goal.find(id)
      if current_user && goal.achiever_id == current_user.id
        return true
      end
    end
    return false
  end
  
  def report_abuse!
    if (params[:goal_id] || params[:id])
      id = params[:goal_id] ? params[:goal_id] : params[:id]
      goal = Goal.find(id)
      if GoalStage::REPORT_ABUSE == goal.goalStage
        flash[:alert] = t("alerts.goal_has_been_reported")
        redirect_to root_path
      end
    end
  end
  
  def is_goal_active?
     if (params[:goal_id] || params[:id])
       id = params[:goal_id] ? params[:goal_id] : params[:id]
       goal = Goal.find(id)
       if GoalStage.active_stages.include? goal.goalStage 
         return true
       end
     end
     false
   end
  
  def is_current_user_charity_update_admin?
    if (params[:charity_id] || params[:id])
      charity_id = params[:charity_id] ? params[:charity_id] : CharityUpdate.find(params[:id]).charity_id.to_s 
      is_current_user_charity_admin? charity_id
    else
      false
    end
  end
  
  def a_charity_administrator_user! 
    unless current_user && (current_user.admin? || current_user.charity_id)
       flash[:alert] =  t('alerts.area_restricted_to_charity_admin')   
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
  
  def crop_image model
    model_name = model.class.name.downcase
    Goalog.info model_name
    Goalog.info "params #{params}"
    model.crop_x = params[model_name][:crop_x]
    model.crop_y = params[model_name][:crop_y]
    model.crop_h = params[model_name][:crop_h]
    model.crop_w = params[model_name][:crop_w]
    model.crop_image  
  end

  # http://guides.rubyonrails.org/i18n.html
  def set_locale
    I18n.locale = [
        # :en, 
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
    texto
  end
  
end
