class GoalTemplatesController < ApplicationController
  before_filter :authenticate_user!
 
  def i_commit
    respond_to do |format|
       format.html { 
         redirect_to "/#{current_user.username}/goals/new?goal_template=#{params[:goal_template]}"
       }
    end
  end
  
end
