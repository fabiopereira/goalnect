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
    find(:all, :conditions => ['active = true AND (LOWER(charity_name) LIKE :q OR LOWER(description) LIKE :q)', {:q => "%#{q.downcase}%"}])
  end
  
  def display_crop_image_view
    false
  end
  
  def how_many_goals_registered
    Goal.find_how_many_goals_registered_to_charity self.id
  end
   
  def how_many_people_donate
   donors_logged =  GoalDonation.how_many_users_donate_to_charity self.id
   annonymous_donors = GoalDonation.how_many_logout_donation_to_charity self.id
   donors_logged + annonymous_donors
  end

  def last_40_active_goals_by_charity
    Goal.find_last_40_active_goals_by_charity self.id
  end
   
  def total_raised
    GoalDonation.find_total_raised_amount_by_charity_id self.id
  end
end
