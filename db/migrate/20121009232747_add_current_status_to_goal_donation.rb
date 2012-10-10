class AddCurrentStatusToGoalDonation < ActiveRecord::Migration
  def change
    add_column :goal_donations, :current_status, :string
  end
end
