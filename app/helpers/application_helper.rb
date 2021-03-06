module ApplicationHelper
  def sign_in_and_redirect_to_current
    '/users/sign_in?user_return_to=' + request.path
  end
  
  def raw_scape_xss (content)
    raw content.gsub('<script>','&lt;script&gt;').gsub('</script>','&lt;/script&gt;')
  end  
  
  def raw_scape_html (content)
      raw content.nil? ? "" : content.gsub('<','&lt;').gsub('>','&gt;').gsub("\n",'<br/>')   
  end
  
  def current_url
    if Rails.env.development? or Rails.env.test?
      'http://' + request.host + ':' + request.port.to_s + request.fullpath
    else
      'http://' + request.host + request.fullpath
    end
  end
  
  def close_fb_popup_path
     if Rails.env.development? or Rails.env.test?
        'http://' + request.host + ':' + request.port.to_s + '/static/close_fb_popup'
      else
        'http://' + request.host + '/static/close_fb_popup'
      end
  end
  
  
  def bool_to_yn b
    b ? I18n.t("names.yes") : I18n.t("names.no")
  end  
  
  GOAL_DONATION_STAGE_ICON = {
    GoalDonationStage::APPROVED               => "icon44",
    GoalDonationStage::PENDING                => "icon110",
    GoalDonationStage::VERIFYING              => "icon110",
    GoalDonationStage::WAITING_NOTIFICATION   => "icon110",
    GoalDonationStage::CANCELED               => "icon56",
    GoalDonationStage::REFUNDED               => "icon56"
  }
  
  FACEBOOK_LOCALE = {
    :en => "en_US",
    :pt => "pt_BR"
  }
  
  def facebook_locale
    FACEBOOK_LOCALE[I18n.locale]
  end
  
  def goal_donation_stage_icon stage
    GOAL_DONATION_STAGE_ICON[stage]
  end
  
  def days_left_for_goal goal
    if goal.days_left > 1
      { :prefix => t('timeLeftPrefix'),
        :amount => goal.days_left,
        :suffix => "#{t('datetime.prompts.day').downcase}s" }
    elsif goal.due_today?
      { :prefix => t("goal.due_on"),
        :amount => t("today"),
        :suffix => "" }
    else # due on the past
      { :prefix => t("goal.due_on"),
        :amount => goal.due_on.day,
        :suffix => goal.due_on.strftime("%b/%Y") }
    end
  end
  
  def active_goal_template_options
    options_for_select (
      [[t("goal_template.select_option"), :goal_template_yours]] + 
      GoalTemplate.all_active_exclude_events_current_locale.map{ |gt|
        [gt.title] + [gt.title]
      } +
      [[t("goal_template.yours"), :goal_template_yours]]
    )
  end
  
  def t_attribute(model, attribute)
    model.human_attribute_name(attribute)
  end
  
end
