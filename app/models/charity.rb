class Charity < ActiveRecord::Base
  attr_accessible :charity_name, :contact_name, :description, :email, :phone
end
