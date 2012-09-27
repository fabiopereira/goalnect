class GoalSupportsController < ApplicationController
  # GET /goal_supports
  # GET /goal_supports.json
  def index
    @goal_supports = GoalSupport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_supports }
    end
  end

  # GET /goal_supports/1
  # GET /goal_supports/1.json
  def show
    @goal_support = GoalSupport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_support }
    end
  end

  # GET /goal_supports/new
  # GET /goal_supports/new.json
  def new
    @goal_support = GoalSupport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_support }
    end
  end

  # GET /goal_supports/1/edit
  def edit
    @goal_support = GoalSupport.find(params[:id])
  end

  # POST /goal_supports
  # POST /goal_supports.json
  def create
    puts 'got to create goal_support'
    @goal_support = GoalSupport.new(params[:goal_support])

    respond_to do |format|
      if @goal_support.save
        format.html { redirect_to @goal_support, notice: 'Goal support was successfully created.' }
        format.json { render json: @goal_support, status: :created, location: @goal_support }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goal_supports/1
  # PUT /goal_supports/1.json
  def update
    @goal_support = GoalSupport.find(params[:id])

    respond_to do |format|
      if @goal_support.update_attributes(params[:goal_support])
        format.html { redirect_to @goal_support, notice: 'Goal support was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_supports/1
  # DELETE /goal_supports/1.json
  def destroy
    @goal_support = GoalSupport.find(params[:id])
    @goal_support.destroy

    respond_to do |format|
      format.html { redirect_to goal_supports_url }
      format.json { head :no_content }
    end
  end
end
