class AddRedemptionPointTransactionIdToGoalDonationPointTransaction < ActiveRecord::Migration
  def change
    add_column :goal_donation_point_transactions, :redemption_point_transaction_id, :integer
  end
end
