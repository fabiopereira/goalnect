class CreateGoalDonations < ActiveRecord::Migration
  def change
    create_table :goal_donations do |t|
      t.text :message
      t.integer :goal_id
      t.integer :user_id
      t.decimal :amount

      t.timestamps
    end
  end
end
