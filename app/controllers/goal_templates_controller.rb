class GoalTemplatesController < ApplicationController
  before_filter :authenticate_user! , :except => [:goal_template_by_title]
 
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
  
end
