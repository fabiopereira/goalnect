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
    @goal_comment = GoalComment.new
    @goal_support = GoalSupport.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /:user_username/goals/new
  # GET /:user_username/goals/new.json
  def new
    @achiever_username = params[:user_username]
    @goal = Goal.new
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
  
  def add_comment
    params[:goal_comment][:goal_id] = params[:goal_id]
    params[:goal_comment][:user_id] = current_user.id
    
    goal = Goal.find_by_id(params[:goal_id])
    if goal.achiever.id == current_user.id
      @goal_comment = GoalComment.new(params[:goal_comment])
      @goal_comment.save
      respond_to do |format| 
          format.json { render json: @goal_comment.to_json(
                :include => {:user => {:only => :screen_name}}
              ), status: :created, location: @goal_comment }
        end
    end
     
  end
  
  def add_support
      goal_supports =  GoalSupport.where(:user_id=>current_user.id).where(:goal_id=>params[:goal_id]);
      if @goal_supports.nil?
         params[:goal_support][:goal_id] = params[:goal_id]
         params[:goal_support][:user_id] = current_user.id
         @goal_support = GoalSupport.create(params[:goal_support])
      else
         @goal_support = goal_supports.first.update_attributes(params[:goal_support])
      end
      support_info
  end
    
  def support_info
    @support = Hash.new
    @support[:support_true_count]  = GoalSupport.where(:goal_id=>params[:goal_id]).where(:i_support=>true).count;
    @support[:support_false_count] = GoalSupport.where(:goal_id=>params[:goal_id]).where(:i_support=>false).count;
    goal_supports = nil
    if current_user
      goal_supports = GoalSupport.where(:user_id=>current_user.id).where(:goal_id=>params[:goal_id]);
    end  
    if goal_supports.nil? || goal_supports.empty?
      @support[:has_given_support] = false;
    else
      @support[:has_given_support] = true;
      @support[:support_value] = goal_supports.first.i_support
    end
    respond_to do |format|
      format.json { render json: @support}  
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
