class CreateGoalSupports < ActiveRecord::Migration
  def change
    create_table :goal_supports do |t|
      t.boolean :i_support
      t.integer :goal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
