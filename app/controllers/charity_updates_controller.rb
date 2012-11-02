class CharityUpdatesController < ApplicationController
  before_filter :a_charity_administrator_user!, :only => [:new, :create]
  before_filter :charity_updates_admin_user!, :only => [:edit, :update, :destroy]
  
  # GET /charity_updates
  # GET /charity_updates.json
  def index
    @charity_updates = CharityUpdate.find(:all,:limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charity_updates }
    end
  end

  # GET /charity_updates/1
  # GET /charity_updates/1.json
  def show
    @charity_update = CharityUpdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charity_update }
    end
  end

  # GET /charity_updates/new
  # GET /charity_updates/new.json
  def new
    @charity_update = CharityUpdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charity_update }
    end
  end

  # GET /charity_updates/1/edit
  def edit
    @charity_update = CharityUpdate.find(params[:id])
  end

  # POST /charity_updates
  # POST /charity_updates.json
  def create
    @charity_update = CharityUpdate.new(params[:charity_update])
    @charity_update.charity_id = current_user.charity_id
    respond_to do |format|
      if @charity_update.save
        format.html { redirect_to @charity_update, notice: 'Charity update was successfully created.' }
        format.json { render json: @charity_update, status: :created, location: @charity_update }
      else
        format.html { render action: "new" }
        format.json { render json: @charity_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charity_updates/1
  # PUT /charity_updates/1.json
  def update
    @charity_update = CharityUpdate.find(params[:id])

    respond_to do |format|
      if @charity_update.update_attributes(params[:charity_update])
        format.html { redirect_to @charity_update, notice: 'Charity update was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charity_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charity_updates/1
  # DELETE /charity_updates/1.json
  def destroy
    @charity_update = CharityUpdate.find(params[:id])
    @charity_update.destroy

    respond_to do |format|
      format.html { redirect_to charity_updates_url }
      format.json { head :no_content }
    end
  end
end
