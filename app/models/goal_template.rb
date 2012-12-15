class GoalTemplate < ActiveRecord::Base
  attr_accessible :active, :description, :title, :locale, :image, :due_on, :goal_template_type_id, :description_guide, :publish_home

  validates_presence_of :title, :description, :locale
  validates_uniqueness_of :title
  
  mount_uploader :image, GoalTemplateImageUploader
  
  def self.all_active_current_locale
    GoalTemplate.where("active = ? and locale = ?", true, I18n.locale.to_s)
  end
  
  def self.all_active_event_current_locale
    GoalTemplate.where("active = ? and locale = ? and goal_template_type_id = ?", true, I18n.locale.to_s, GoalTemplateType::EVENT.id)
  end
  
  def self.home_events_current_locale
    GoalTemplate.where("active = ? and locale = ? and goal_template_type_id = ? and publish_home = ?", true, I18n.locale.to_s, GoalTemplateType::EVENT.id, true)
  end
  
  def goal_template_type
    GoalTemplateType.find(self.goal_template_type_id)
  end
  
  def self.find_all_active_events
    today = Date.today
    @events = GoalTemplate.find(:all, :conditions => ["due_on >= ? and goal_template_type_id = ?  and active = ?  and locale = ?", today, GoalTemplateType::EVENT.id, true, I18n.locale.to_s], :order => "due_on")
  end
  
  
  def self.search_active_events title_query
    today = Date.today
    @events = GoalTemplate.find(:all, :conditions => ["due_on >= ? and goal_template_type_id = ? and active = ?  and locale = ? and LOWER(title) like ?", today, GoalTemplateType::EVENT.id, true, I18n.locale.to_s, "%#{title_query}%"], :order => "due_on")
  end
  
  
  def top_10_goals
    goals = Goal.find_all_by_goal_template_id(self.id)
    # goals.sort_by{|e| -e[:raised_so_far]}
    #          .first(2)
    goals
  end
  
end
