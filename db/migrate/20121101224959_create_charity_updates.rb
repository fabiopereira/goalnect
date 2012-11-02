class CreateCharityUpdates < ActiveRecord::Migration
  def change
    create_table :charity_updates do |t|
      t.integer :charity_id
      t.text :message

      t.timestamps
    end
  end
end
