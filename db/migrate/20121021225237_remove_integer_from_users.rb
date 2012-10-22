class RemoveIntegerFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :integer
  end

  def down
  end
end
