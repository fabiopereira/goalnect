class GoalDonationPaymentNotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def confirm
    if request.post?
      pagseguro_notification do |notification|
        logger.debug "NOTIFICATION RECEIVED FROM PagSeguro: POST"
        logger.debug "YAML #{YAML::dump(notification)}" 
        if notification.products.length == 1 && notification.valid?
          goal_donation = GoalDonation.find(notification.order_id)
          return unless !goal_donation.nil?
          @donation_payment = map_donation_payment notification
          if @donation_payment.save
            goal_donation.current_status = @donation_payment.status
            goal_donation.save
          end 
        end
      end
      render :nothing => true
    else
      logger.debug "REDIRECT FROM PagSeguro: GET"
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Donation received, waiting for pagseguro to confirm.' }
      end
    end
  end
  
  def map_donation_payment notification
    product = notification.products.first
    donation_payment = GoalDonationPaymentNotification.new
    donation_payment.currency = 'BRL'
    donation_payment.donor_email = notification.buyer[:email]
    donation_payment.donor_name = notification.buyer[:name]
    donation_payment.fees = product[:fees]
    donation_payment.goal_donation_id = notification.order_id
    donation_payment.payment_channel = 'pagseguro'
    donation_payment.payment_method = notification.payment_method
    donation_payment.price = product[:price]
    donation_payment.processed_at = notification.processed_at
    donation_payment.status = notification.status
    donation_payment.transaction_id = notification.transaction_id
    donation_payment
  end
end