class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.integer :goal_id
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end
end
