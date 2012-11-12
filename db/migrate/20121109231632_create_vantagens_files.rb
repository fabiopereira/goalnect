class CreateVantagensFiles < ActiveRecord::Migration
  def change
    create_table :vantagens_files do |t|
      t.string :file
      t.string :file_name
      t.datetime :sent_at
      t.timestamps
    end
  end
end
