class AddCharityAndTargeAmountToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :charity_id, :integer
    add_column :goals, :target_amount, :decimal
  end
end
