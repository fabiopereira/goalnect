class Charity < ActiveRecord::Base
  
  attr_accessible :charity_name, :contact_name, :description, :email, :phone, :logo, :active, :cnpj, :nickname, :website
  attr_accessible :pagseguro_authenticity_token, :pagseguro_email
  
  # CarrierWave Image Uploads
  attr_accessible :image
  mount_uploader :image, CharityImageUploader

  validates_presence_of :charity_name, :contact_name, :email, :phone, :nickname
  
  validates_uniqueness_of :nickname
  
  def to_s
    "#{id} - #{charity_name}"
  end
  
  def full_url
    "/charities/#{self.id}"
  end
  
  def self.search(q)
    find(:all, :conditions => ['LOWER(charity_name) LIKE :q OR LOWER(description) LIKE :q', {:q => "%#{q.downcase}%"}])
  end
  
  def find_most_recent_donations
    GoalDonation.find_most_recent_donations_by_charity_id self.id
  end
  
  def find_total_raised_amount
    GoalDonation.find_total_raised_amount_by_charity_id self.id
  end
  
  def display_crop_image_view
    false
  end
   
end
