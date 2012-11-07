class GoalsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :support_info]
  include GoalsHelper
  # GET /:user_username/goals
  # GET /:user_username/goals.json
  def index
    @achiever = getAchiever
    @goals = Goal.find_all_by_achiever_id(@achiever.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goals }
    end
  end

  # GET /:user_username/goals/1
  # GET /:user_username/goals/1.json
  def show
    @goal = Goal.find(params[:goal_id])
    @goal_feedback = GoalFeedback.new
    @goal_feedback.goal_stage_id = @goal.goal_stage_id
    display_show_page
  end

  def display_show_page
     @tab = params[:tab]
     @goal_support = GoalSupport.new
     respond_to do |format|
      format.html {render 'show.html.erb'}
      format.json { render json: @goal }
     end
  end
  
  def fill_goal_with_template_if_exists
    if params[:goal_template] && params[:goal_template] != :goal_template_yours.to_s
      goal_template = GoalTemplate.find(params[:goal_template])
      @goal.title = goal_template.title
      @goal.description = goal_template.description
    end
  end
  
  # GET /:user_username/goals/new
  # GET /:user_username/goals/new.json
  def new
    @achiever_username = params[:user_username]
    @goal = Goal.new
    flash[:notice] = t('goal_template.congratulations_almost_there') 
    fill_goal_with_template_if_exists
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal}
    end
  end

  # GET /:user_username/goals/1/edit
  def edit
    @goal = Goal.find(params[:id])
    @achiever = @goal.achiever
  end

  def create
    params[:goal][:achiever] = find_achiever(params)
    params[:goal][:owner] = current_user    
    @goal = Goal.new(params[:goal])
    @achiever_username = params[:user_username]
    @goal.goal_stage_changed_at = Time.now
    if @goal.owner.id == @goal.achiever.id
      @goal.goal_stage_id = GoalStage::JUST_STARTED.id
    else
       @goal.goal_stage_id = GoalStage::PENDING.id
    end
    respond_to do |format|
      if @goal.save
          format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), notice: 'Goal was successfully created.' }
      else
          format.html { render action: "new" }
      end
    end
  end
  
  def add_feedback
    params[:goal_feedback][:goal_id] = params[:goal_id]
    params[:goal_feedback][:user_id] = current_user.id
    @goal = Goal.find_by_id(params[:goal_id])
    @tab = "goal-journey-tab"
    feedback_validation
    @goal_feedback = GoalFeedback.new(params[:goal_feedback])
    if @goal_feedback.save
      update_goal_status @goal_feedback, @goal
      @goal_feedback = GoalFeedback.new
    end
    display_show_page
  end
  
  def feedback_validation
     if GoalStage::DONE == @goal.goalStage
        raise 'This goal is done, you cannot change it status or add new feedbacks'
      end
      if @goal.achiever.id != current_user.id
        raise 'You are not the achiever of this goal, you cannot add feedbacks'
      end
  end
  
  def update_goal_status goal_feedback, goal
    if GoalStage::DONE != goal.goalStage && goal_feedback.goal_stage_id != goal.goal_stage_id
      goal.goal_stage_id = goal_feedback.goal_stage_id
      goal.goal_stage_changed_at = goal_feedback.created_at
      goal.save
    end
  end
  
  def change_stage
    @goal = Goal.find(params[:goal_id])
    if @goal.achiever.id == current_user.id
      @goal.goal_stage_changed_at = Time.now
      @goal.update_attributes(params[:goal])
    end
     respond_to do |format|
      format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id) }  
     end
  end
 
  def find_achiever(params)
    achiever_username = params[:user_username]
    if (current_user.username == achiever_username)
      current_user
    else
      User.find_by_username(achiever_username)
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
  
  def i_support
    create_support true
  end
  
  def i_dont_support
    create_support false
  end
  
  def create_support support_flag
    if current_user
      @goal_support =  GoalSupport.find(:first, :conditions => ["goal_id = ? and user_id = ?", params[:goal_id], current_user.id])
      if @goal_support.nil?
        @goal_support = GoalSupport.new
      end
      @goal_support.goal_id = params[:goal_id]
      @goal_support.user_id = current_user.id
      @goal_support.i_support = support_flag
      @goal_support.save
    end
    respond_to do |format|
       format.html { redirect_to show_goal_path(params[:user_username], params[:goal_id])}
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
