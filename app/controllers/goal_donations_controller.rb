class GoalDonationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  before_filter :is_goal_active!, :only => [:new]          
  before_filter :is_goal_donation_waiting_notification, :only => [:show]
  
  GOALNECT_FEE_PERCENTAGE = 0.075
  
  # GET /goal_donations/new
  # GET /goal_donations/new.json
  def new
    @goal = Goal.find(params[:goal_id])
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
    @goal = Goal.find(params[:goal_donation][:goal_id])
    params[:goal_donation][:charity_id] = @goal.charity_id
    @goal_donation = GoalDonation.new(params[:goal_donation])
    @goal_donation.current_stage_id = GoalDonationStage::WAITING_NOTIFICATION.id
    apply_goalnect_fee @goal_donation
    respond_to do |format|
      if @goal_donation.save
        format.html { redirect_to "/goal_donations/show/"+@goal_donation.id.to_s }
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
    @order.add :id => @goal_donation.charity.id, :price => @goal_donation.decimal_amount, :description => "#{I18n.t("donation_to")} #{@goal_donation.charity.charity_name}"
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
    @goal = Goal.find(@goal_donation.goal_id)
  end

 def populate_pagseguro_fee
    # if PagSeguro.developer?
      # What to do here?!?!
    # else
      PagseguroFee.populate_pagseguro_fees params
      render :nothing => true
    # end
  end
  
end
