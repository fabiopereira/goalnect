class GoalOptionsController < ApplicationController
  # GET /goal_options
  # GET /goal_options.json
  def index
    @goal_options = GoalOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_options }
    end
  end

  # GET /goal_options/1
  # GET /goal_options/1.json
  def show
    @goal_option = GoalOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_option }
    end
  end

  # GET /goal_options/new
  # GET /goal_options/new.json
  def new
    @goal_option = GoalOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_option }
    end
  end

  # GET /goal_options/1/edit
  def edit
    @goal_option = GoalOption.find(params[:id])
  end

  # POST /goal_options
  # POST /goal_options.json
  def create
    @goal_option = GoalOption.new(params[:goal_option])

    respond_to do |format|
      if @goal_option.save
        format.html { redirect_to @goal_option, notice: 'Goal option was successfully created.' }
        format.json { render json: @goal_option, status: :created, location: @goal_option }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goal_options/1
  # PUT /goal_options/1.json
  def update
    @goal_option = GoalOption.find(params[:id])

    respond_to do |format|
      if @goal_option.update_attributes(params[:goal_option])
        format.html { redirect_to @goal_option, notice: 'Goal option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_options/1
  # DELETE /goal_options/1.json
  def destroy
    @goal_option = GoalOption.find(params[:id])
    @goal_option.destroy

    respond_to do |format|
      format.html { redirect_to goal_options_url }
      format.json { head :no_content }
    end
  end
end
