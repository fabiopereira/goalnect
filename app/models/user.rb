class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :screen_name
  # attr_accessible :title, :body
  
  has_many :authentications, :dependent => :delete_all
  
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
