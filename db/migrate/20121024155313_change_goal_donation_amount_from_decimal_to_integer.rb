class ChangeGoalDonationAmountFromDecimalToInteger < ActiveRecord::Migration
  def up          
    rename_column :goal_donations, :amount, :amount_decimal
    add_column :goal_donations, :amount, :integer   
    GoalDonation.update_all("amount = amount_decimal")
    remove_column :goal_donations, :amount_decimal  
  end

  def down
  end
end
