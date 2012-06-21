class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :screen_name
  # attr_accessible :title, :body
  
  
  def self.search(q)
    find(:all, :conditions => ['username LIKE :q OR screen_name LIKE :q OR email LIKE :q', {:q => "%#{q}%"}])
  end
  
  def full_url
    "/#{self.username}"
  end

end
