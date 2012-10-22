class GoalDonationObserver < ActiveRecord::Observer
  
  PAYMENT_STATUS_COMPLETED = 'completed'
  PAYMENT_STATUS_APPROVED = 'approved'
  
  
  def after_save(goal_donation)
    if should_process_points? goal_donation
      create_point_transaction_achiever goal_donation
      create_point_transation_donor goal_donation
    end
  end
  
  def create_point_transaction_achiever goal_donation
     create_point_transaction goal_donation goal_donation.goal.achiever_id
  end
   
  def create_point_transation_donor goal_donation
    if goal_donation.user_id
      create_point_transaction goal_donation goal_donation.user_id
    end
  end
   
  def create_point_transaction goal_donation, user_id
    point_transaction = GoalDonationPointTransaction.new
    point_transaction.goal_donation_id = goal_donation.id
    point_transaction.goal_id = goal_donation.goal_id
    point_transaction.point_amount = goal_donation.amount
    point_transaction.user_id = user_id
    point_transaction.active = goal_donation.goal.goalStage == GoalStage::DONE
    save_point_transaction point_transaction
  end
     
   def save_point_transaction point_transaction
     if point_transaction.save
       Goalog.debug "point_transaction saved => #{YAML::dump(point_transaction)}"
     else
       Goalog.critical "Could not save point_transaction => #{YAML::dump(point_transaction)} due to errors #{point_transaction.errors.inspect}"
     end
   end
  
  def should_process_points? goal_donation
    !goal_donation.processed && (goal_donation.current_status == PAYMENT_STATUS_COMPLETED || goal_donation.current_status == PAYMENT_STATUS_APPROVED)
  end
  
end