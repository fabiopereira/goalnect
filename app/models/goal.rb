class Goal < ActiveRecord::Base        
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  attr_accessible :description, :due_on, :owner, :title, :achiever, :goal_stage_id, :goal_stage_changed_at
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'

  belongs_to_active_hash :goalStage 
  has_many :goal_donations

  validates_presence_of :description, :due_on, :owner, :title

  def self.find_goals_dared_by(user)
    find(:all, :conditions => ['achiever_id != :u and owner_id = :u', {:u => user.id}])
  end
  
  def self.find_active_goals(user)
    find(:all, :conditions => ['achiever_id = :u and goal_stage_id != :abandoned and  goal_stage_id != :not_accepted', {:u => user.id, :abandoned => GoalStage::ABANDONED.id, :not_accepted => GoalStage::NOT_ACCEPTED.id}])
  end
  
  def find_comments
    GoalComment.find_all_by_goal_id(self.id)
  end
  
end
