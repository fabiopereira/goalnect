class HomeController < ApplicationController
  #before_filter :authenticate_user!
  include GoalExplorer

  def index
    @goals = Goal.landing
    respond_to do |format|
      format.html 
    end
  end

end
