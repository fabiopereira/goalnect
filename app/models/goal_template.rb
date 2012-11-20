class GoalTemplate < ActiveRecord::Base
  attr_accessible :active, :description, :title, :locale, :image

  validates_presence_of :active, :description, :locale
  
  mount_uploader :image, GoalTemplateImageUploader
  
  def self.all_active_current_locale
    GoalTemplate.where("active = ? and locale = ?", true, I18n.locale.to_s)
  end
end
