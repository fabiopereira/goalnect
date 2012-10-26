require 'factory_girl_rails'

FactoryGirl.define do
  factory :active_charity, class: Charity do
    sequence(:charity_name) {|n| "Charity #{n}"}
    sequence(:nickname) {|n| "Charity#{n}"}
    contact_name {|c| "Contact #{c.charity_name}"}
    sequence(:email) {|n| "charity#{n}@mycharitydomain.com"}
    phone "2323424234"
    active true
  end
end 
