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
    @redemption_point_transaction.for_user current_user

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /redemption_point_transactions
  # POST /redemption_point_transactions.json
  def create
    @redemption_point_transaction = RedemptionPointTransaction.new(params[:redemption_point_transaction])
    @redemption_point_transaction.for_user current_user

    respond_to do |format|
      if @redemption_point_transaction.save
        format.html { redirect_to @redemption_point_transaction, notice: 'Redemption point transaction was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /redemption_point_transactions/1
  # PUT /redemption_point_transactions/1.json
  def update
    @redemption_point_transaction = RedemptionPointTransaction.find(params[:id])

    respond_to do |format|
      if @redemption_point_transaction.update_attributes(params[:redemption_point_transaction])
        format.html { redirect_to @redemption_point_transaction, notice: 'Redemption point transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @redemption_point_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redemption_point_transactions/1
  # DELETE /redemption_point_transactions/1.json
  def destroy
    @redemption_point_transaction = RedemptionPointTransaction.find(params[:id])
    @redemption_point_transaction.destroy

    respond_to do |format|
      format.html { redirect_to redemption_point_transactions_url }
      format.json { head :no_content }
    end
  end
end
