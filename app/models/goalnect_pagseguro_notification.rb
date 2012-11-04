class GoalnectPagseguroNotification
  
  STATUS_TO_STAGE = {
    :completed  => GoalDonationStage::APPROVED, 
    :pending    => GoalDonationStage::PENDING,
    :approved   => GoalDonationStage::APPROVED,
    :verifying  => GoalDonationStage::VERIFYING,
    :canceled   => GoalDonationStage::CANCELED,
    :refunded   => GoalDonationStage::REFUNDED
  }
  
  def initialize(notification)
    @notification = notification
    validate
  end
  
  def notification
    @notification
  end
  
  def save_goal_donation_payment_notification
    @donation_payment = map_donation_payment
    if @donation_payment.save
      @goal_donation.current_stage_id = @donation_payment.stage_id
      @goal_donation.save
    else
      raise "Could not save PagSeguro notification due to errors #{@donation_payment.errors.inspect}"
    end 
  end
  
  def map_donation_payment
    product = @notification.products.first
    donation_payment = GoalDonationPaymentNotification.new
    donation_payment.currency = 'BRL'
    donation_payment.donor_email = @notification.buyer[:email]
    donation_payment.donor_name = @notification.buyer[:name]
    donation_payment.fees = product[:fees]
    donation_payment.goal_donation_id = @notification.order_id
    donation_payment.payment_channel = 'pagseguro'
    donation_payment.payment_method = @notification.payment_method
    donation_payment.price = product[:price]
    donation_payment.processed_at = @notification.processed_at
    donation_payment.stage_id = STATUS_TO_STAGE[@notification.status].id
    donation_payment.transaction_id = @notification.transaction_id
    donation_payment
  end

  def validate
    Goalog.debug "NOTIFICATION RECEIVED FROM PagSeguro: POST"
    Goalog.debug "YAML #{YAML::dump(@notification)}"
    
    if !@notification.valid?
      raise "Invalid notification notification.valid? == false #{YAML::dump(@notification)}" 
    end
    
    if @notification.products.nil? || @notification.products.length == 0
      raise "Received notification without products #{YAML::dump(@notification)}"
    end
    
    if @notification.products.length > 1
      Goalog.critical "Received notification with #{@notification.products.length} products #{YAML::dump(@notification)}"
    end
    
    @goal_donation = GoalDonation.find(@notification.order_id)
    if @goal_donation.nil?
      raise "Could not find GoalDonation for notification.order_id #{@notification.order_id}  #{YAML::dump(@notification)}"
    end
  end
  
end