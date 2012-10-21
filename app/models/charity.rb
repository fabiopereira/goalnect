class Charity < ActiveRecord::Base
  attr_accessible :charity_name, :contact_name, :description, :email, :phone, :logo, :active, :cnpj, :nickname
  
  validates_presence_of :charity_name, :contact_name, :email, :phone
  
  validates_uniqueness_of :nickname
end
