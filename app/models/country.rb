class Country < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {:id => 1, :name => "Australia", :locale => "en"},
    {:id => 2, :name => "Brasil", :locale => "pt"}
  ]
  enum_accessor :name
  
  def self.current_from_locale
    if I18n.locale.to_s == "pt"
      Country::BRASIL
    else 
      Country::AUSTRALIA
    end
    # locale = I18n.locale
    # 
    # # puts "-------------------> #{I18n.locale}"
    # # 
    # # locale = "pt"
    # current = Country.find_by_locale locale.to_s
    # raise "Could not find country for locale #{locale}" unless current
  end
  
end