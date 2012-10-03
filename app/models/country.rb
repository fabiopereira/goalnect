class Country < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "Australia"},
    {:id => 2, :name => "Brasil"}
  ]
  enum_accessor :name
end