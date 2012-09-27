class GoalSupport < ActiveRecord::Base
  attr_accessible :goal_id, :i_support, :user_id
  
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
   belongs_to :goal, :class_name => 'Goal', :foreign_key => 'goal_id'

   validates_presence_of :goal_id
   
end

