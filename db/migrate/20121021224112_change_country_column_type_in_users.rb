class ChangeCountryColumnTypeInUsers < ActiveRecord::Migration
 
  def up
    remove_column :users, :country_id
    add_column :users, :country_id, :integer, :default => 1
  end

  def down
  end
end
