class GoalObserver < ActiveRecord::Observer

  def after_save(goal)  
    eta = goal.due_on + 3.days
    Goalog.info 'GOALDONATIONOBERSER!!!!!!!! => ' + eta.to_s
    if GoalStage::DONE == goal.goalStage && goal.goal_stage_changed_at < eta
      GoalDonationPointTransaction.update_all ['active = ?', true], ['goal_id = ?', goal.id]
    end
  end
  
end
