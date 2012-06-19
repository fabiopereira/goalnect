class CreateGoalOptions < ActiveRecord::Migration
  def change
    create_table :goal_options do |t|
      t.string :name
      t.boolean :is_system

      t.timestamps
    end
  end
end
