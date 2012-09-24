class DropFutureUsers < ActiveRecord::Migration
  def up
    drop_table :future_users
  end

  def down
  end
end
