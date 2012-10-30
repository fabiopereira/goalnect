class GoalDonationPaymentNotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
             
  def handle_notification notification
      goalnect_pagseguro_notification = GoalnectPagseguroNotification.new(notification)
      goalnect_pagseguro_notification.save_goal_donation_payment_notification
  end
  
  def confirm
    if request.post?
      begin                                           

        @goal_donation = GoalDonation.find(params[:Referencia])
        if @goal_donation.nil?
          raise "Could not find GoalDonation for params[:Referencia] #{params[:Referencia]}"
        end
        token = @goal_donation.goal.charity.pagseguro_authenticity_token
        
        pagseguro_notification(token) do |notification|
          handle_notification notification
        end                    
        
        render :nothing => true
        
      rescue Exception => e
        Goalog.critical_exception "Error processing PagSeguro Notification #{YAML::dump(@notification)}", e
      end
        
    else
      Goalog.debug "REDIRECT FROM PagSeguro: GET"
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Donation received, waiting for pagseguro to confirm.' }
      end
    end
    
    
  end
  
end