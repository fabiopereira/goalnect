class GoalTemplatesController < ApplicationController
  before_filter :authenticate_user!
 
  def i_commit
    new_goal_url = "/#{current_user.username}/goals/new"
    new_goal_url += "?goal_template=#{params[:goal_template]}" if params[:goal_template]
    respond_to do |format|
       format.html { 
         redirect_to new_goal_url
       }
    end
  end
  
end
