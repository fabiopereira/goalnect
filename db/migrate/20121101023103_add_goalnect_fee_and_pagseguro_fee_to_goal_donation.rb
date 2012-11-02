class AddGoalnectFeeAndPagseguroFeeToGoalDonation < ActiveRecord::Migration
  def change
    add_column :goal_donations, :goalnect_fee, :decimal
    add_column :goal_donations, :pagseguro_fee, :decimal
  end
end
