class GoalDonationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  GOALNECT_FEE_PERCENTAGE = 0.075
  
  # GET /goal_donations/new
  # GET /goal_donations/new.json
  def new
    @goal_donation = GoalDonation.new
    @goal_donation.goal_id = params[:goal_id]
    @goal_donation.current_stage_id = GoalDonationStage::WAITING_NOTIFICATION.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_donation }
    end
  end
  
  # POST /goal_donations
  # POST /goal_donations.json
  def create
    if current_user
      params[:goal_donation][:user_id] = current_user.id
      params[:goal_donation][:donor_name] = current_user.screen_name
    end
    goal = Goal.find(params[:goal_donation][:goal_id])
    params[:goal_donation][:charity_id] = goal.charity_id
    @goal_donation = GoalDonation.new(params[:goal_donation])
    @goal_donation.current_stage_id = GoalDonationStage::WAITING_NOTIFICATION.id
    apply_goalnect_fee @goal_donation
    respond_to do |format|
      if @goal_donation.save
        format.html { redirect_to "/goal_donations/show/"+@goal_donation.id.to_s, notice: 'Goal donation was successfully created.' }
        format.json { render json: @goal_donation, status: :created, location: @goal_donation }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_donation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def apply_goalnect_fee goal_donation
    if goal_donation.amount
      goal_donation.goalnect_fee = goal_donation.amount * GOALNECT_FEE_PERCENTAGE
    end
  end
  
  def show
    @goal_donation = GoalDonation.find(params[:id])
    @order = PagSeguro::Order.new(@goal_donation.id)
    @order.add :id => @goal_donation.id, :price => @goal_donation.amount, :description => "donation"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_donation }
    end
  end
  
  # GET /goal_donations
  # GET /goal_donations.json
  def index
    @goal_donations = GoalDonation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_donations }
    end
  end

  # GET /goal_donations/1/edit
  def edit
    @goal_donation = GoalDonation.find(params[:id])
  end


  # PUT /goal_donations/1
  # PUT /goal_donations/1.json
  def update
    @goal_donation = GoalDonation.find(params[:id])

    respond_to do |format|
      if @goal_donation.update_attributes(params[:goal_donation])
        format.html { redirect_to @goal_donation, notice: 'Goal donation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_donation.errors, status: :unprocessable_entity }
      end
    end
  end

  
end
