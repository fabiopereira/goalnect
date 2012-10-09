class GoalDonationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  # GET /goal_donations/new
  # GET /goal_donations/new.json
  def new
    @goal_donation = GoalDonation.new
    @goal_id = params[:goal_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_donation }
    end
  end
  
  # POST /goal_donations
  # POST /goal_donations.json
  def create
    
    params[:goal_donation][:goal_id] = params[:goal_id]
    params[:goal_donation][:user_id] = current_user.id
    @goal_donation = GoalDonation.new(params[:goal_donation])

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
  
  def show
    puts 'goal donation show!!!!!!!!!!!!!!!!!!!!!!!!'
    @goal_donation = GoalDonation.find(params[:id])
    puts 'Goal DONATION ID: ' + @goal_donation.id.to_s
    #validar if there is payment for this donation...
    @order = PagSeguro::Order.new(@goal_donation.id)
    @order.add :id => @goal_donation.id, :price => @goal_donation.amount, :description => "donation"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_donation }
    end
  end
  
  def confirm
    return unless request.post?
    
    pagseguro_notification do |notification|
      logger.debug "NOTIFICATION RECEIVED FROM PagSeguro:"
      
      ap "VALID? #{notification.valid?}"
      ap "TransacaoID? #{notification.transaction_id}"
      ap "#{notification.inspect}"
      ap "PRODUCTS #{notification.products}"
      ap "BUYER #{notification.buyer}"
      ap "STATUS #{notification.status}"
      ap "PAYMENT #{notification.payment_method}"
      ap "PROC_AT #{notification.processed_at}"
      # Aqui você deve verificar se o pedido possui os mesmos produtos
      # que você cadastrou. O produto só deve ser liberado caso o status
      # do pedido seja "completed" ou "approved"
    end

    render :nothing => true
  end
  
  
  
  
  
  
  
  # # GET /goal_donations/1
  # # GET /goal_donations/1.json
  # def show
  #   @goal_donation = GoalDonation.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @goal_donation }
  #   end
  # end
  
  def donation_payment
    
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




  
   def donate_order
     # Busca o pedido associado ao usuário; esta lógica deve
     # ser implementada por você, da maneira que achar melhor
     @goal_donation_order = GoalDonationOrder.create(params[:goal_donation])
  # Instanciando o objeto para geração do formulário

   end



   def donation_confirmation
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

  # DELETE /goal_donations/1
  # DELETE /goal_donations/1.json
  def destroy
    @goal_donation = GoalDonation.find(params[:id])
    @goal_donation.destroy

    respond_to do |format|
      format.html { redirect_to goal_donations_url }
      format.json { head :no_content }
    end
  end
end
