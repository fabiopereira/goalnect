class HomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @goals = Goal.find(:all, :limit => 4, :order => "id desc")
    respond_to do |format|
      format.html 
    end
  end

end
