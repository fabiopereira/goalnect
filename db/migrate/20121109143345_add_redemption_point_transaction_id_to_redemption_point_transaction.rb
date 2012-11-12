class AddRedemptionPointTransactionIdToRedemptionPointTransaction < ActiveRecord::Migration
  def change
    add_column :redemption_point_transactions, :redemption_point_transaction_id, :integer
  end
end
