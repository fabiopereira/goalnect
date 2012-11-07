class Country < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "Australia", :locale => "en"},
    {:id => 2, :name => "Brasil", :locale => "pt"}
  ]
  enum_accessor :name
  
  def self.current_from_locale
    Country.find_by_locale I18n.locale.to_s
  end
  
end