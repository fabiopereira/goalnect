class AddNicknameToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :nickname, :string
  end
end
