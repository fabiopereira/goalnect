class GoalTemplate < ActiveRecord::Base
  attr_accessible :active, :description, :title, :locale, :image, :due_on, :goal_template_type_id, :description_guide, :publish_home

  validates_presence_of :title, :active, :description, :locale
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
  
end
