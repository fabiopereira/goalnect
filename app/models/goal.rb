class Goal < ActiveRecord::Base
  attr_accessible :description, :due_on, :owner, :title, :achiever
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'

  validates_presence_of :description, :due_on, :owner, :title

  def self.find_by_achiever_id(q)
    find(:all, :conditions => ['achiever_id = :q', {:q => "#{q}"}])
  end
  
end
