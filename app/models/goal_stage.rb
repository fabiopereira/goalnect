class GoalStage < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "pending"},
    {:id => 2, :name => "not_accepted"},
    {:id => 3, :name => "just_started"},
    {:id => 4, :name => "half_way_there"},
    {:id => 5, :name => "almost_there"},
    {:id => 6, :name => "done"},
    {:id => 7, :name => "abandoned"}
  ]
  enum_accessor :name
  
  def self.possible_goal_stage_updates
    values = [
      GoalStage::HALF_WAY_THERE, 
      GoalStage::ALMOST_THERE, 
      GoalStage::DONE, 
      GoalStage::ABANDONED]
  end
  
  def translated_name
      I18n.t(name, :scope => 'goal_stage')
  end
  
  
end
