class CreateGoalCommentsOld < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.text :message
      t.integer :goal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
