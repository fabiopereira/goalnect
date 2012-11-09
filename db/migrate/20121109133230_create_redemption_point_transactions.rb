class CreateRedemptionPointTransactions < ActiveRecord::Migration
  def change
    create_table :redemption_point_transactions do |t|
      t.integer :user_id
      t.integer :point_amount
      t.decimal :money_amount, :scale => 2
      t.string  :cpf
      t.processed :boolean

      t.timestamps
    end
  end
end
