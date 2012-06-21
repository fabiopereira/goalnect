class RenameUserUrlToUsername < ActiveRecord::Migration
  def change
    rename_column :users, :url, :username
  end
end
