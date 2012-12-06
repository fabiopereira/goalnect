class GoalnectionSummary
  
  attr_reader :goalnections
  
  def initialize(user) 
    donations = GoalDonation.find_all_by_user_id_and_current_stage_id(user.id,  GoalDonationStage::APPROVED.id)
    puts "donations => #{donations.size}"
    updates = GoalComment.find_all_by_user_id(user.id)
    puts "updates => #{updates.size}"
    supports = GoalSupport.find_all_by_user_id(user.id)
    puts "supports => #{supports.size}"
    goals_created_by = Goal.find_active_goals_created_by(user)
    puts "goals_created_by => #{goals_created_by.size}"

    group_by_goal = Hash.new
    
    process_donations group_by_goal, donations
    process_updates group_by_goal, updates
    process_supports group_by_goal, supports
    process_dares group_by_goal, goals_created_by
    @goalnections = group_by_goal.values
    
  end   
  
  def process_donations group_by_goal, donations
    if donations && !donations.empty?
      donations.each do |donation|
        goalnection = retrieve_goalnection group_by_goal, donation.goal  
        if goalnection.donation
          goalnection.donation = goalnection.donation + donation.amount
        else
          goalnection.donation = donation.amount
        end
      end
    end
  end
  
  def process_updates group_by_goal, updates
    if updates && !updates.empty?
      updates.each do |update|
        goalnection = retrieve_goalnection group_by_goal, update.goal
        goalnection.update = true
      end
    end
  end
  
  def process_supports group_by_goal, supports
    if supports && !supports.empty?
      supports.each do |support|
        goalnection = retrieve_goalnection group_by_goal, support.goal
        goalnection.i_support = support.i_support
      end
    end
  end
  
  def process_dares group_by_goal, goals_created_by
    if goals_created_by && !goals_created_by.empty?
      goals_created_by.each do |goal|
        goalnection = retrieve_goalnection group_by_goal, goal
        goalnection.goal_created_by = goal.owner
      end
    end
  end
  
  def retrieve_goalnection group_by_goal, goal
    goalnection = group_by_goal[goal.id]
    if !goalnection
      goalnection = Goalnection.new
      goalnection.goal = goal
      group_by_goal[goal.id] = goalnection
    end
    goalnection
  end
  
end
