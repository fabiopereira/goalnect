class User < ActiveRecord::Base
  
 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :screen_name, :dob, :country_id, :unconfirmed_email, :about_me, :admin, :charity_id, :charity
  
  # CarrierWave Image Uploads
  attr_accessible :image
  mount_uploader :image, ImageUploader
  include CropImage
   
  #belongs_to_active_hash :country  
  has_many :authentications, :dependent => :delete_all
  
  belongs_to :charity
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^(?!_)(?:[a-z0-9]_?)*[a-z](?:_?[a-z0-9])*(?<!_)$/i

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    self.screen_name = auth['extra']['raw_info']['first_name'] + ' ' + auth['extra']['raw_info']['last_name']
    self.username = 'fb' + auth['extra']['raw_info']['username'].delete('^a-zA-Z0-9')
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
  
  def self.search(q)
    find(:all, :conditions => ['LOWER(username) LIKE :q OR LOWER(screen_name) LIKE :q OR LOWER(email) LIKE :q', {:q => "%#{q.downcase}%"}])
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
  
  def find_5_most_recent_updates
    GoalFeedback.find(:all, :limit => 5, :conditions => ["user_id = ?", self.id], :order=> 'created_at desc')
  end
  
  def points_summary active_flag
    GoalDonationPointTransaction.sum(:point_amount, :conditions => ['user_id = ? and active = ?', self.id, active_flag])
  end

end
