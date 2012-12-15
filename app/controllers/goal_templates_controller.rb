class GoalTemplatesController < ApplicationController
  before_filter :authenticate_user! , :only => [:i_commit]
 
  def i_commit
    new_goal_url = "/#{current_user.username}/goals/new"
    new_goal_url += "?goal_template=#{params[:goal_template]}" if params[:goal_template]
    respond_to do |format|
       format.html { 
         redirect_to new_goal_url
       }
    end
  end
  
  def goal_template_by_title
    @goal_template = GoalTemplate.find(:first, :conditions => ["title = ?", params[:title]])
    respond_to do |format|
      format.json { render json: @goal_template }
    end
  end
  
  def events
    today = Date.today
    if params[:event_q] && !params[:event_q].blank?
      @events = GoalTemplate.search_active_events params[:event_q]
    else
      @events = GoalTemplate.find_all_active_events
    end
  end
  
  def show_event
    @event = GoalTemplate.find(params[:event_id])
    
    if !@event || @event.goal_template_type_id != GoalTemplateType::EVENT.id
      respond_to do |format|
        format.html {redirect_to :root, alert: t("event.not_found") }
      end
    end
    
  end
  
end
