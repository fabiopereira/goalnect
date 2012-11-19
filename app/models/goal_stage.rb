class GoalStage < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "pending"},
    {:id => 2, :name => "not_accepted"},
    {:id => 3, :name => "just_started"},
    {:id => 4, :name => "on_its_way"},
    {:id => 5, :name => "half_way_there"},
    {:id => 6, :name => "almost_there"},
    {:id => 7, :name => "done"},
    {:id => 8, :name => "abandoned"},
    {:id => 9, :name => "report_abuse"}
  ]
  enum_accessor :name
  
  def self.possible_goal_stage_updates
    values = [
      GoalStage::JUST_STARTED,
      GoalStage::ON_ITS_WAY,
      GoalStage::HALF_WAY_THERE, 
      GoalStage::ALMOST_THERE, 
      GoalStage::DONE, 
      GoalStage::ABANDONED]
  end
  
  def self.active_stages
     values = [
        GoalStage::JUST_STARTED,
        GoalStage::ON_ITS_WAY,
        GoalStage::HALF_WAY_THERE, 
        GoalStage::ALMOST_THERE, 
        GoalStage::DONE]
  end
  
  def self.inactive_stages_id
    values = [
        GoalStage::NOT_ACCEPTED.id,
        GoalStage::ABANDONED.id,
        GoalStage::REPORT_ABUSE.id]
  end
  
  def self.active_stages_id
    values = []
    active_stages.each do |stage|
      values << stage.id
    end
    values
  end
  
  def translated_name
      I18n.t(name, :scope => 'goal_stage')
  end
  
  
end
