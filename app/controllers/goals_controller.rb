class GoalsController < ApplicationController
  before_filter :authenticate_user!
  include GoalsHelper
  # GET /:user_username/goals
  # GET /:user_username/goals.json
  def index
    @achiever = getAchiever
    @goals = Goal.find_by_achiever_id(@achiever.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goals }
    end
  end

  # GET /:user_username/goals/1
  # GET /:user_username/goals/1.json
  def show
    @goal = Goal.find(params[:id])
    @achiever = @goal.achiever

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /:user_username/goals/new
  # GET /:user_username/goals/new.json
  def new
    @achiever = getAchiever

    @goal = Goal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /:user_username/goals/1/edit
  def edit
    @goal = Goal.find(params[:id])
    @achiever = @goal.achiever
  end

  # POST /:user_username/goals
  # POST /:user_username/goals.json
  def create
    params[:goal][:owner] = current_user
    achiever_id = params[:goal][:achiever]
    if (current_user.id == achiever_id)
      params[:goal][:achiever] = current_user
      params[:goal][:status] = 2
    else
      params[:goal][:achiever] = User.find(achiever_id)
      params[:goal][:status] = 1
    end
    params[:goal][:option] = GoalOption.find(params[:goal][:option])

    @goal = Goal.new(params[:goal])

    respond_to do |format|

      if @goal.save
        format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), notice: 'Goal was successfully created.'}
        format.json { render json: @goal, status: :created, location: @goal }
      else
        format.html { redirect_to new_goal_path(params[:goal][:achiever][:username]) }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /:user_username/goals/1
  # PUT /:user_username/goals/1.json
  def update
    @goal = Goal.find(params[:id])
    @achiever = @goal.achiever
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to show_goal_path(@achiever.username, @goal.id), notice: 'Goal was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { redirect_to edit_goal_path(@achiever.username, @goal.id)}
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:user_username/goals/1
  # DELETE /:user_username/goals/1.json
  #  def destroy
  #    @goal = Goal.find(params[:id])
  #
  #    @goal.destroy
  #
  #    respond_to do |format|
  #      format.html { redirect_to goals_path(@goal.achiever.username)}
  #      format.json { head :no_content }
  #    end
  #  end

  def getAchiever
    user_username = params[:user_username]
    if (user_username == current_user.username)
      current_user
    else
      User.find_by_username(user_username)
    end
  end

end
