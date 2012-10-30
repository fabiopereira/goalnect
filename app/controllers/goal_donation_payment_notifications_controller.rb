class GoalDonationPaymentNotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
             
  def handle_notification notification
    begin                                           
      goalnect_pagseguro_notification = GoalnectPagseguroNotification.new(notification)
      goalnect_pagseguro_notification.save_goal_donation_payment_notification
    rescue Exception => e
      Goalog.critical_exception "Error processing PagSeguro Notification #{YAML::dump(@notification)}", e
    end
  end
  
  def confirm
    if request.post?
      token = PagSeguro.config["authenticity_token"]
      pagseguro_notification(token) do |notification|
        handle_notification notification
      end
      render :nothing => true
    else
      Goalog.debug "REDIRECT FROM PagSeguro: GET"
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Donation received, waiting for pagseguro to confirm.' }
      end
    end
  end
  
end