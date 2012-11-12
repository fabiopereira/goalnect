class ChangeColumnGoalnectFeeToHaveScaleTwo < ActiveRecord::Migration
  def change
    change_column :goal_donations, :goalnect_fee, :decimal, :precision => 5, :scale => 2
    change_column :goal_donations, :pagseguro_fee, :decimal, :precision => 5, :scale => 2
  end
end
