class GoalTemplateType < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "standard"},
    {:id => 2, :name => "event"}
  ]
  enum_accessor :name
  
  def translated_name
      I18n.t(name, :scope => 'goal_template_type')
  end
  
  def to_s
    name
  end
  
end
