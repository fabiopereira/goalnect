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
  
  def get_token
    @goal_donation = GoalDonation.find(params[:Referencia])
    if @goal_donation.nil?
      Goalog.critical "Could not find GoalDonation for params[:Referencia] #{params[:Referencia]}"
    end
    @goal_donation.goal.charity.pagseguro_authenticity_token
  end
  
  def confirm
    print_params
    if request.post?
        pagseguro_notification(get_token) do |notification|
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
  
  def print_params
     Goalog.critical "Params values"
    params.each_pair do |k,v|
      Goalog.critical "#{k} => #{v}"
    end
  end
  
end