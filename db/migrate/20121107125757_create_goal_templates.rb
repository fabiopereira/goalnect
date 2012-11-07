class CreateGoalTemplates < ActiveRecord::Migration
  def change
    create_table :goal_templates do |t|
      t.string :title
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
