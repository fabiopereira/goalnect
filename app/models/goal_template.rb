class GoalTemplate < ActiveRecord::Base
  attr_accessible :active, :description, :title, :locale

  validates_presence_of :active, :description, :locale
  
  def self.all_active
    GoalTemplate.where("active = ? and locale = ?", true, I18n.locale.to_s)
  end
end
