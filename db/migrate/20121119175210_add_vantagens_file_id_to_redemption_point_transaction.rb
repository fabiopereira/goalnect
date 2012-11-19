class AddVantagensFileIdToRedemptionPointTransaction < ActiveRecord::Migration
  def change
    add_column :redemption_point_transactions, :vantagens_file_id, :integer
  end
end
