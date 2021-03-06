class GoalsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :support_info, :explore]
  before_filter :report_abuse!, :except => [:new, :create]
  before_filter :is_goal_active!, :except => [:accept_challenge, :reject_challenge, :new, :create, :show]
  before_filter :goal_show!, :only => [:show]
  before_filter :is_current_user_achiever, :only  => [:accept_challenge, :reject_challenge, :add_feedback, :change_stage, :edit]
  
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
    if (@goal.achiever.username != params[:user_username])
      respond_to do |format|
        format.html {redirect_to :root, alert: t("alerts.goal_doesnt_belong_to_achiever") }
      end
    else
      @goal_comment = GoalComment.new
      @goal_comment.goal_id = @goal.id
      display_show_page
    end
  end

  def display_show_page
     @tab = params[:tab]
     @goal_support = GoalSupport.new
     respond_to do |format|
      format.html {render 'show.html.erb'}
      format.json { render json: @goal }
     end
  end
  
  def fill_goal_with_template_if_exists goal
    if params[:goal_template] && params[:goal_template] != :goal_template_yours.to_s
      goal.title_selected = params[:goal_template]
    end
  end
  
  # GET /:user_username/goals/new
  # GET /:user_username/goals/new.json
  def new
    achiever_username = params[:user_username] ? params[:user_username] : current_user.username
    achiever = User.find_by_username(achiever_username)
    @goal = Goal.new 
    @goal.achiever = achiever
    fill_goal_with_template_if_exists @goal
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal}
    end
  end

  # GET /:user_username/goals/1/edit
  def edit
    @goal = Goal.find(params[:goal_id])
    @achiever = @goal.achiever
  end

  def create
    params[:goal][:achiever] = find_achiever(params)
    params[:goal][:owner] = current_user    
    @goal = Goal.new(params[:goal])
    @goal.goal_stage_changed_at = Time.now
    if @goal.owner.id == @goal.achiever.id
      @goal.goal_stage_id = GoalStage::JUST_STARTED.id
    else
       @goal.goal_stage_id = GoalStage::PENDING.id
    end
    @goal.publish_home = true
    respond_to do |format|
     if @goal.save
        if @goal.achiever_id == current_user.id
          format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), notice: t("goal_created_successful_messge") }
        else
          format.html {redirect_to :root, notice: t("dare_created_successful_messge") }
        end
      else
          format.html { render action: "new" }
      end
    end
  end
  
  def goal_done
    goal_change_status GoalStage::DONE, t("goal_done.goal_created_successful_messge") ,t("goal_done.failed_to_set_goal_status_done")
  end
  
  def goal_abandoned
    goal_change_status GoalStage::ABANDONED, t("goal_abandoned_message") ,t("failed_to_set_goal_as_abandoned")
  end
  
  def goal_change_status goal_stage, successful_msg, fail_msg
    @goal = Goal.find_by_id(params[:goal_id])
    if @goal.achiever.id != current_user.id
      @goal.errors[:achiever_id] << t('goal_done.you_are_not_achiever_error_msg')
    end
    if GoalStage::DONE == @goal.goalStage
      @goal.errors[:goal_stage_id] << t('goal_done.goal_is_already_done_error_msg')
    end
    @goal.goal_stage_id = goal_stage.id
    @goal.goal_stage_changed_at = Time.now
    respond_to do |format|
      if @goal.errors.empty? && @goal.save
        format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), notice: successful_msg }
      else
        Goalog.info "#{fail_msg} => #{YAML::dump(@goal.errors)}"
        format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), alert: fail_msg }
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
  
  def accept_challenge
    params[:goal] = {:goal_stage_id => GoalStage::JUST_STARTED.id}
    change_stage
  end
  
  def reject_challenge
    params[:goal] = {:goal_stage_id => GoalStage::NOT_ACCEPTED.id}
    change_stage
  end
  
  def report_abuse
    @goal = Goal.find(params[:goal_id])
    if current_user && current_user.charity_id && current_user.charity_id == @goal.charity_id
      params[:goal] = {:goal_stage_id => GoalStage::REPORT_ABUSE.id}
      if @goal.update_attributes(params[:goal])
          flash[:notice] = t('report_abuse_success_message') 
          @goal_feedback = GoalFeedback.new
          display_show_page
          return
      end
    end
    respond_to do |format|
      format.html { redirect_to show_goal_path(@goal.achiever.username, @goal.id), alert: t("errors.charity.report_abuse_error")  }
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
    @goal = Goal.find(params[:goal_id])
    @achiever = @goal.achiever
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to show_goal_path(@achiever.username, @goal.id), notice: t('goal_was_updated_msg')}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def explore
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

  def add_comment
     @goal_comment = GoalComment.new(params[:goal_comment])
     @goal_comment.goal_id = params[:goal_id]
     @goal_comment.user = current_user
     respond_to do |format|
          if @goal_comment.save
            format.json { render json: @goal_comment, status: :created, location: @goal_comment }
          else
            format.json { render json: @goal_comment.errors, status: :unprocessable_entity }
          end
    end
  end
  
  def goal_comment_url goal_comment
    #rails need this method for the json add_comment to work, since we don't have all the url for goal_comment in the routes..
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
