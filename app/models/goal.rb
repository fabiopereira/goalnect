class Goal < ActiveRecord::Base
  attr_accessible :achieved_on, :achiever, :description, :due_on, :option, :owner, :status
  
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_user_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_user_id'
  belongs_to :option, :class_name => 'GoalOption', :foreign_key => 'goal_option_id'
  
  def self.find_by_achiever_id(q)
    find(:all, :conditions => ['achiever_user_id = :q', {:q => "#{q}"}])
  end
  
  
end
