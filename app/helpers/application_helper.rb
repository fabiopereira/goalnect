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
  
  def goal_donation_stage_icon stage
    GOAL_DONATION_STAGE_ICON[stage]
  end
  
  def active_goal_template_options
    active_options = GoalTemplate.all_active_current_locale.map{ |gt|
      [gt.title] + [gt.id]
    }
    options_for_select (
      [[t("goal_template.select_option")]] + 
      active_options +
      [[t("goal_template.yours"), :goal_template_yours]]
    )
  end
  
end
