class GoalCommentsController < ApplicationController
  before_filter :authenticate_user!
  # GET /goal_comments
  # GET /goal_comments.json
  def index
    @goal_comments = GoalComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_comments }
    end
  end

  # GET /goal_comments/1
  # GET /goal_comments/1.json
  def show
    @goal_comment = GoalComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_comment }
    end
  end

  # GET /goal_comments/new
  # GET /goal_comments/new.json
  def new
    @goal_comment = GoalComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_comment }
    end
  end

  # GET /goal_comments/1/edit
  def edit
    @goal_comment = GoalComment.find(params[:id])
  end

  # POST /goal_comments
  # POST /goal_comments.json
  def create
    @goal_comment = GoalComment.new(params[:goal_comment])

    respond_to do |format|
      if @goal_comment.save
        format.html { redirect_to @goal_comment, notice: 'Goal comment was successfully created.' }
        format.json { render json: @goal_comment, status: :created, location: @goal_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goal_comments/1
  # PUT /goal_comments/1.json
  def update
    @goal_comment = GoalComment.find(params[:id])

    respond_to do |format|
      if @goal_comment.update_attributes(params[:goal_comment])
        format.html { redirect_to @goal_comment, notice: 'Goal comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_comments/1
  # DELETE /goal_comments/1.json
  def destroy
    @goal_comment = GoalComment.find(params[:id])
    @goal_comment.destroy

    respond_to do |format|
      format.html { redirect_to goal_comments_url }
      format.json { head :no_content }
    end
  end
end
