class EmailType < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "donation_received"},
    {:id => 2, :name => "goal_without_donations"}
  ]
  enum_accessor :name

  
  
end
