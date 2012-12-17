require 'time_diff'

class Goal < ActiveRecord::Base        
  MIN_TARGET_AMOUNT = 50

  attr_accessible :title, :title_selected
  attr_accessible :description, :due_on, :created_at, :owner, :owner_id, :achiever, :goal_stage_id, :goal_stage_changed_at, :charity_id, :charity, :target_amount, :achiever_id, :goal_template_id
  
  attr_accessor :raised_so_far_amount
  
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :achiever, :class_name => 'User', :foreign_key => 'achiever_id'
  belongs_to :charity
  belongs_to :goal_template

  has_many :goal_donations
  has_many :goal_supports

  validates_presence_of :description, :due_on, :owner, :title, :charity_id, :target_amount
  validate :not_past_date, :on => :create
  validates :target_amount, :numericality => { :greater_than_or_equal_to => MIN_TARGET_AMOUNT }
  
  def title_selected
    self.title
  end

  def due_today?
    due_on == Date.today
  end
  
  def days_left 
    if due_today?
      1
    elsif due_on > Date.today
      ((due_on.to_time - Time.now).abs/60/60/24).round
    else
      0
    end
  end
  
  def not_past_date
    if self.due_on.past? 
      errors.add(:due_on, I18n.t("cannot_be_in_the_past"))
    end
  end
  
  def title_selected=(title_selected)
    self.title = title_selected
    if (title_selected.present?)
      goal_template = GoalTemplate.find_by_title(title_selected)
      if goal_template
        self.goal_template = goal_template
        self.title = goal_template.title
        if goal_template.due_on
          self.due_on = goal_template.due_on
        end
      end
    end
  end

  scope :active, where('goal_stage_id not in (:inactive)', {:inactive => GoalStage.inactive_stages_id})
  scope :in_progress_stages, where('goal_stage_id in (:in_progress_stages)', {:in_progress_stages => GoalStage.in_progress_stages})
  scope :latest_in_progress, in_progress_stages.order('id desc')
  scope :latest, active.order('id desc')
  scope :landing_limit, limit(4)
  scope :explore_limit, limit(3)
  scope :landing, latest_in_progress.landing_limit
  scope :no_goal_template, active.limit(30).where('goal_template_id is null')
  scope :random_scope, active.order('random()')
    
  def self.find_goals_dared_by(user)
    find(:all, :conditions => ['achiever_id != :u and owner_id = :u', {:u => user.id}])
  end
  
  def self.find_active_goals_dared_by(user)
    find(:all, :conditions => ['achiever_id != :u and owner_id = :u and goal_stage_id not in (:inactive)', {:u => user.id, :inactive => GoalStage.inactive_stages_id}])
  end
  
  def self.find_active_goals_created_by(user)
    find(:all, :conditions => [' owner_id = :u and goal_stage_id not in (:inactive)', {:u => user.id, :inactive => GoalStage.inactive_stages_id}])
  end
  
  def self.find_active_goals(user)
    find(:all, :conditions => ['achiever_id = :u and goal_stage_id not in (:inactive)', {:u => user.id, :inactive => GoalStage.inactive_stages_id}], :order => "id desc")
  end
  
  def find_feedback
    GoalFeedback.find_all_by_goal_id(self.id)
  end
  
  def find_comments
    GoalComment.find_all_by_goal_id(self.id, :order => "id desc")
  end
  
  def find_most_recent_donations_by_goal_id 
    GoalDonation.find_most_recent_donations_by_goal_id self.id
  end 
  
  def goal_donations_to_display
    GoalDonation.find_all_to_display_by_goal_id self.id
  end        
  
  def goalStage
      GoalStage.find(self.goal_stage_id)
  end
  
  def self.search(q)
    find(:all, :conditions => ['LOWER(description) LIKE :q OR LOWER(title) LIKE :q', {:q => "%#{q.downcase}%"}])
  end
  
  def self.find_how_many_goals_registered_to_charity charity_id
    Goal.count(:id, :conditions => ["charity_id = ? and goal_stage_id in (?)", charity_id, GoalStage.active_stages])
  end
  
  def self.find_last_40_active_goals_by_charity charity_id
    Goal.find(:all, :conditions => [ "charity_id = ? and goal_stage_id in (?)", charity_id, GoalStage.active_stages], :limit => 40, :order => "id desc")
  end
  
  def self.find_goals_without_donations start_date, end_date
    Goal.includes(:goal_donations).where("goal_donations.id is null and goals.created_at between ? and ?  and goal_stage_id in (?)", start_date, end_date, GoalStage.active_stages_except_done)    
  end
  
  def support_for current_user
    goal_supports.detect { |s| s.user_id == current_user.id} if current_user
  end
  
  def supports_from_boolean support
    goal_supports.select { |x| x.i_support == support }
  end
  
  def support_names support
    supports_from_boolean(support).map{|goal_support| goal_support.user.screen_name }
  end
  
  def list_support_true
    supports_from_boolean(true)
  end
  
  def list_support_false
    supports_from_boolean(false)
  end
  
  def how_many_believe
    supports_from_boolean(true).length
  end
  
  def how_many_dont_believe
    supports_from_boolean(false).length
  end
  
  def raised_so_far
    if !raised_so_far_amount
      total = 0          
      goal_donations.each{ |d| total = total + d.amount if  d.current_stage == GoalDonationStage::APPROVED}
      raised_so_far_amount = total
    end
    raised_so_far_amount
  end
  
  def raised_so_far_percentage
    (raised_so_far / target_amount) * 100
  end
  
  def is_there_donations_for_this_goal
    GoalDonation.is_there_donations_for_this_goal self.id
  end
  
end
