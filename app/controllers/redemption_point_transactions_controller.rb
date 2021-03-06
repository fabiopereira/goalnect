class RedemptionPointTransactionsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /redemption_point_transactions
  # GET /redemption_point_transactions.json
  def index
    @redemption_point_transactions = RedemptionPointTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @redemption_point_transactions }
    end
  end

  # GET /redemption_point_transactions/1
  # GET /redemption_point_transactions/1.json
  def show
    @redemption_point_transaction = RedemptionPointTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @redemption_point_transaction }
    end
  end

  # GET /redemption_point_transactions/new
  # GET /redemption_point_transactions/new.json
  def new
    @redemption_point_transaction = RedemptionPointTransaction.new
    @redemption_point_transaction.user = current_user

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /redemption_point_transactions
  # POST /redemption_point_transactions.json
  def create
    @redemption_point_transaction = RedemptionPointTransaction.new
    @redemption_point_transaction.cpf = params[:redemption_point_transaction][:cpf]
    @redemption_point_transaction.user = current_user

    respond_to do |format|
      if @redemption_point_transaction.save
        format.html { redirect_to "#{current_user.full_url}/points_statement", 
           notice: t("redemption.redeem_success_message", 
             :redeemed_points => @redemption_point_transaction.point_amount) }
      else
        format.html { render action: "new" }
      end
    end
  end

end
