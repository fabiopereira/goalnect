class GoalDonationStage < ActiveHash::Base
  include ActiveHash::Enum
  
  self.data = [
    {:id => 0, :name => "waiting_notification"},
    {:id => 1, :name => "approved"},
    {:id => 2, :name => "pending"},
    {:id => 3, :name => "verifying"},
    {:id => 4, :name => "canceled"},
    {:id => 5, :name => "refunded"}
  ]
  enum_accessor :name
  
end
