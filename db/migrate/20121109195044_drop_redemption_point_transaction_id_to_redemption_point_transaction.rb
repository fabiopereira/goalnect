class DropRedemptionPointTransactionIdToRedemptionPointTransaction < ActiveRecord::Migration
  def change
    remove_column :redemption_point_transactions, :redemption_point_transaction_id
  end
end
