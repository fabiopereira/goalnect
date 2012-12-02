class GoalComment < ActiveRecord::Base
  attr_accessible :goal_id, :message, :user_id, :created_at

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :goal, :class_name => 'Goal', :foreign_key => 'goal_id'
  
  validates_presence_of :goal_id, :message, :user_id
  
  def created_at_formated
    I18n.l(created_at, :format => :short)
  end
  
  def as_json(options = {})
      json = super(options)
      json['created_at_formated'] = created_at_formated
      json
  end
  
end
