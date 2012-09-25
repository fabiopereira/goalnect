class CreateGoalsAgain < ActiveRecord::Migration

  def change
    create_table :goals do |t|
      t.integer :owner_id
      t.text :description
      t.string :title
      t.date :due_on
      t.integer :achiever_id
      t.integer :status_id
      t.timestamps
    end
    add_index :goals, [:owner_id]
    add_index :goals, [:achiever_id]
  end
  
end
