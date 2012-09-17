class AddDobAndCountryToUser < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :country_id, :string
    add_column :users, :integer, :string
  end
end
