class Goal < ActiveRecord::Base        
  #extend ActiveHash::Associations::ActiveRecordExtensions
  
  attr_accessible :description, :due_on, :owner, :title, :achiever, :goal_stage_id, :goal_stage_changed_at, :charity_id, :charity, :target_amount, :achiever_id
  
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'
  belongs_to :charity, :class_name => 'Charity', :foreign_key => 'charity_id'

  #belongs_to_active_hash :goalStage 
  has_many :goal_donations

  validates_presence_of :description, :due_on, :owner, :title, :charity_id, :target_amount

  def self.find_goals_dared_by(user)
    find(:all, :conditions => ['achiever_id != :u and owner_id = :u', {:u => user.id}])
  end
  
  def self.find_active_goals(user)
    find(:all, :conditions => ['achiever_id = :u and goal_stage_id != :abandoned and  goal_stage_id != :not_accepted', {:u => user.id, :abandoned => GoalStage::ABANDONED.id, :not_accepted => GoalStage::NOT_ACCEPTED.id}])
  end
  
  def find_feedback
    GoalFeedback.find_all_by_goal_id(self.id)
  end
  
  def find_most_recent_donations_by_goal_id 
    GoalDonation.find_most_recent_donations_by_goal_id self.id
  end         
  
  def goalStage
      GoalStage.find(self.goal_stage_id)
  end
  
  def self.search(q)
    find(:all, :conditions => ['LOWER(description) LIKE :q OR LOWER(title) LIKE :q', {:q => "%#{q.downcase}%"}])
  end
  
end
