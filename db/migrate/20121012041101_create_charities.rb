class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :charity_name
      t.text :description
      t.string :contact_name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
