class AddCharityIdToUserAndAddLogoCharity < ActiveRecord::Migration
  def change
    add_column :users, :charity_id, :integer   
    add_column :charities, :image, :string
    add_column :charities, :website, :string
  end
end
