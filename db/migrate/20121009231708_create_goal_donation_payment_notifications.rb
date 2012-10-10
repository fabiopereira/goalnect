class CreateGoalDonationPaymentNotifications < ActiveRecord::Migration
  def change
    create_table :goal_donation_payment_notifications do |t|
      t.integer :goal_donation_id
      t.string :transaction_id
      t.decimal :price
      t.decimal :fees
      t.string :donor_name
      t.string :donor_email
      t.string :status
      t.string :payment_method
      t.datetime :processed_at
      t.string :currency
      t.string :payment_channel

      t.timestamps
    end
  end
end
