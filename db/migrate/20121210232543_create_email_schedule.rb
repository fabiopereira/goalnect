class CreateEmailSchedule < ActiveRecord::Migration
  def change
    create_table :email_schedules do |t|
      t.integer :email_type_id
      t.datetime :next_start_date
      t.timestamps
    end
  end
end
