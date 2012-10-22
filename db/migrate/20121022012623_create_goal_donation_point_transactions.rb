class CreateGoalDonationPointTransactions < ActiveRecord::Migration
  def change
    create_table :goal_donation_point_transactions do |t|
      t.integer :goal_donation_id
      t.integer :goal_id
      t.integer :user_id
      t.integer :point_amount
      t.boolean :active
      t.timestamps
    end
  end
end
