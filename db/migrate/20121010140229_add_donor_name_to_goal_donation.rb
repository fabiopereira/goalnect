class AddDonorNameToGoalDonation < ActiveRecord::Migration
  def change
    add_column :goal_donations, :donor_name, :string
  end
end
