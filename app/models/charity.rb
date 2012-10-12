class Charity < ActiveRecord::Base
  attr_accessible :charity_name, :contact_name, :description, :email, :phone
  
  validates_presence_of :charity_name, :contact_name, :email, :phone
  
end
