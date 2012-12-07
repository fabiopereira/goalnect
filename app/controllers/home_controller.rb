class HomeController < ApplicationController
  #before_filter :authenticate_user!
  include GoalExplorer

  def index
    # @goals = Goal.landing
    @goals = []
    respond_to do |format|
      format.html 
    end
  end

end
