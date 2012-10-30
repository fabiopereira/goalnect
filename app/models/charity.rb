class Charity < ActiveRecord::Base
  
  attr_accessible :charity_name, :contact_name, :description, :email, :phone, :logo, :active, :cnpj, :nickname, :website
  attr_accessible :pagseguro_authenticity_token, :pagseguro_email
  
  # CarrierWave Image Uploads
  attr_accessible :image
  mount_uploader :image, ImageUploader
  include CropImage
  
  validates_presence_of :charity_name, :contact_name, :email, :phone, :nickname
  
  validates_uniqueness_of :nickname
  
  def to_s
    charity_name
  end
  
  def self.search(q)
    find(:all, :conditions => ['LOWER(charity_name) LIKE :q OR LOWER(description) LIKE :q', {:q => "%#{q.downcase}%"}])
  end
  
end
