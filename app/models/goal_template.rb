class GoalTemplate < ActiveRecord::Base
  attr_accessible :active, :description, :title, :locale

  validates_presence_of :active, :description, :locale
end
