class AddLocaleToGoalTemplate < ActiveRecord::Migration
  def change
    add_column :goal_templates, :locale, :string
  end
end
