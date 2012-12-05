class HomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @goals = Goal.find(:all, 
            :limit => 4, 
            :conditions => ['goal_stage_id not in (:inactive)', {:inactive => GoalStage.inactive_stages_id}],
            :order => "id desc")
    respond_to do |format|
      format.html 
    end
  end

end
