class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :screen_name, :dob, :country_id, :unconfirmed_email
  # attr_accessible :title, :body
  
  belongs_to :country
    
  has_many :authentications, :dependent => :delete_all
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^(?!_)(?:[a-z0-9]_?)*[a-z](?:_?[a-z0-9])*(?<!_)$/i
  
  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    self.screen_name = auth['extra']['raw_info']['first_name'] + ' ' + auth['extra']['raw_info']['last_name']
    self.username = auth['extra']['raw_info']['email']
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
  
  def self.search(q)
    find(:all, :conditions => ['username LIKE :q OR screen_name LIKE :q OR email LIKE :q', {:q => "%#{q}%"}])
  end
  
  def full_url
    "/#{self.username}"
  end

end
