class GoalDonationObserver < ActiveRecord::Observer

  TO_BE_PROCESSED_STATUSES = [:completed, :approved]
  
  def after_save(goal_donation)
    Goalog.debug "GoalDonationObserver called!!! => #{YAML::dump(goal_donation)}"
    if should_process_points? goal_donation
      create_point_transaction_achiever goal_donation
      create_point_transation_donor goal_donation
      goal_donation.processed = true
      goal_donation.save
    end
  end
  
  def create_point_transaction_achiever goal_donation
     create_point_transaction goal_donation, goal_donation.goal.achiever_id
  end
   
  def create_point_transation_donor goal_donation
    if goal_donation.user_id
      create_point_transaction goal_donation, goal_donation.user_id
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
    not_processsed = !goal_donation.processed 
    not_processsed && TO_BE_PROCESSED_STATUSES.include?(goal_donation.current_status)
  end
  
end