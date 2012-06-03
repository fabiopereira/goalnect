class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :url, :string, :null => false, :default => ""
    add_column :users, :screen_name, :string, :null => false, :default => ""
	
	add_index :users, :url, :unique => true
	
	User.update_all ["url = email"]
	User.update_all ["screen_name = email"]
  end
end
