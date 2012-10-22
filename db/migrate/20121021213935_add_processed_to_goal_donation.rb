class AddProcessedToGoalDonation < ActiveRecord::Migration
  def change
    add_column :goal_donations, :processed, :bool
  end
end
