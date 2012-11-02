class AddCharityIdToGoalDonation < ActiveRecord::Migration
  def change
    add_column :goal_donations, :charity_id, :integer
    goal_donations = GoalDonation.all
    goal_donations.each{ |d| 
      d.charity_id = d.goal.charity_id
      d.save
    }
  end
end
