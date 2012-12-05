class CharitiesController < ApplicationController
  before_filter :charity_admin_user!, :only => [:edit, :update, :change_logo, :crop, :donations, :previous_month_donations_pdf, :current_month_donations_pdf, :donations_pdf, :show_goals]
  
  # GET /charities
  # GET /charities.json
  def index
    @charities = Charity.find_all_by_active(true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charities }
    end
  end

  # GET /charities/1
  # GET /charities/1.json
  def show
    nickname_or_id = params[:id]
    if is_number? nickname_or_id
      @charity = Charity.find(nickname_or_id)
    else
      @charity = Charity.find(:first, :conditions => [ "lower(nickname) = ?", nickname_or_id.downcase ])
    end
    respond_to do |format|
      if @charity.active
        format.html # show.html.erb
        format.json { render json: @charity }
      else
        format.html {redirect_to :root, alert: t("charity_is_not_active")  }
      end
    end
  end
  
  def show_goals
    charity_id = params[:charity_id]
    @goals = Goal.find(:all, :conditions => [ "charity_id = ? and created_at > ? and goal_stage_id not in (?)", charity_id, 7.days.ago, GoalStage.inactive_stages_id], :order => "id desc")
    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @goals }
    end
  end
  
  def donations
    end_of_today = Time.now.end_of_day
    beginning_current_month = end_of_today.beginning_of_month
    beginning_previous_month = end_of_today.prev_month.beginning_of_month
    end_previous_month = end_of_today.prev_month.end_of_month.end_of_day
    @charity = Charity.find(params[:id])
    @current_donations_summary = CharityDonationsSummary.new({:from => beginning_current_month, :to => end_of_today, :charity_id => params[:id]})
    @previous_donations_summary = CharityDonationsSummary.new({:from => beginning_previous_month, :to => end_previous_month, :charity_id => params[:id]})
    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @previous_donations_summary }
     end
  end
  
  def previous_month_donations_pdf
    time_now = Time.now
    beginning_previous_month = time_now.prev_month.beginning_of_month
    end_previous_month = time_now.prev_month.end_of_month.end_of_day
    donations_pdf beginning_previous_month, end_previous_month
  end
  
  def current_month_donations_pdf
    end_of_day = Time.now.end_of_day
    beginning_current_month = end_of_day.beginning_of_month
    donations_pdf beginning_current_month, end_of_day
  end
  
  def donations_pdf from, to
    @charity_donations = CharityDonations.new({:from => from, :to => to, :charity_id => params[:id]})
    respond_to do |format|
      format.pdf do
        pdf = CharityDonationsPdf.new(@charity_donations, view_context)
        send_data pdf.render, filename: pdf.file_name,
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
  
  
  def is_number? s
    s.match(/^\d+$/) == nil ? false : true 
  end

  # GET /charities/new
  # GET /charities/new.json
  def new
    @charity = Charity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charity }
    end
  end

  # GET /charities/1/edit
  def edit
    @charity = Charity.find(params[:id])
  end

  def change_logo
    edit
  end
  
  # POST /charities
  # POST /charities.json
  def create
    @charity = Charity.new(params[:charity])
    nickname = remover_acentos(@charity.charity_name)
    @charity.nickname = nickname.delete('^a-zA-Z0-9')
    respond_to do |format|
      if @charity.save
        format.html { redirect_to root_url, notice: I18n.t('charities.charity_registered')}
        format.json { render json: @charity, status: :created, location: @charity }
      else
        format.html { render action: "new" }
        format.json { render json: @charity.errors, status: :unprocessable_entity }
      end
    end
  end

  def crop
    @charity = Charity.find(params[:id])
    crop_image @charity    
    respond_to do |format|
      format.html { redirect_to @charity }
    end
  end
end
