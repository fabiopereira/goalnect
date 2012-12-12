class EmailSchedule < ActiveRecord::Base
  attr_accessible :email_type_id, :next_start_date
end