class Goal < ActiveRecord::Base        
  #extend ActiveHash::Associations::ActiveRecordExtensions
  
  attr_accessible :description, :due_on, :owner, :achiever, :goal_stage_id, :goal_stage_changed_at, :charity_id, :charity, :target_amount, :achiever_id, :goal_template_id
  
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'
  belongs_to :charity
  belongs_to :goal_template

  #belongs_to_active_hash :goalStage 
  has_many :goal_donations
  has_many :goal_supports

  validates_presence_of :description, :due_on, :owner, :title, :charity_id, :target_amount
  
  attr_accessible :title
  def title_selected
    self.title
  end
  
  def title_selected=(title_selected)
    if (title.present?)
      self.title = title_selected
      goal_template = GoalTemplate.find_by_title(title_selected)
      if goal_template
        self.goal_template_id = goal_template.id
        self.title = goal_template.title
        self.description = goal_template.description
      end
    end
  end
  
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
  
  def support_for current_user
    goal_supports.detect { |s| s.user_id == current_user.id} if current_user
  end
  
  def how_many_believe
    goal_supports.select { |x| x.i_support }.length
  end
  
  def how_many_dont_believe
    goal_supports.select { |x| !x.i_support }.length
  end
  
  def raised_so_far
    total = 0          
    goal_donations.each{ |d| total = total + d.amount if  d.current_stage == GoalDonationStage::APPROVED}
    total
  end
  
  def raised_so_far_percentage
    (raised_so_far / target_amount) * 100
  end
  
end
