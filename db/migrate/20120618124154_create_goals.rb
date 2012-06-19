class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :owner_user_id
      t.integer :achiever_user_id
      t.integer :goal_option_id
      t.integer :status
      t.text :description
      t.date :achieved_on
      t.date :due_on

      t.timestamps
    end
    add_index :goals, [:achiever_user_id]
  end
end
