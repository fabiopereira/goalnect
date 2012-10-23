class PointsController < ApplicationController
  
  def points_statement
    @user = User.find_by_username(params[:user_username])
    @point_transactions = GoalDonationPointTransaction.find_by_user_id(@user.id)
    respond_to do |format|
      format.html # points_statement.html.erb
      format.json { render json: @point_transactions }
    end
  end
  
end
