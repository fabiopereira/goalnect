class Country < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "Australia"},
    {:id => 2, :name => "Brasil"}
  ]
end