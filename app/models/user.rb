class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :screen_name, :dob, :country_id, :unconfirmed_email, :about_me, :admin
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  #belongs_to_active_hash :country  
  has_many :authentications, :dependent => :delete_all
  
  # CarrierWave Image Uploads
  attr_accessible :image
  mount_uploader :image, ImageUploader
  after_update :crop_image  
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^(?!_)(?:[a-z0-9]_?)*[a-z](?:_?[a-z0-9])*(?<!_)$/i
  
  def crop_image
    image.recreate_versions! if crop_x.present?
  end  
  
  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    self.screen_name = auth['extra']['raw_info']['first_name'] + ' ' + auth['extra']['raw_info']['last_name']
    self.username = 'fb' + auth['extra']['raw_info']['username'].delete('^a-zA-Z0-9')
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
  
  def self.search(q)
    find(:all, :conditions => ['username LIKE :q OR screen_name LIKE :q OR email LIKE :q', {:q => "%#{q}%"}])
  end
  
  def find_my_goals
    Goal.find_all_by_achiever_id(self.id)
  end
  
  def find_goals_i_dared
    Goal.find_goals_dared_by(self)
  end
  
  def find_active_goals
    Goal.find_active_goals(self)
  end
  
  def full_url
    "/#{self.username}"
  end

  def country
    Country.find self.country_id
  end

end
