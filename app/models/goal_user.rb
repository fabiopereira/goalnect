class GoalUser < ActiveRecord::Base
  attr_accessible :achiever, :goal
  
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'
  belongs_to :goal
  
  def self.find_by_achiever_id(q)
    find(:all, :conditions => ['achiever_id = :q', {:q => "#{q}"}])
  end
  
  
end