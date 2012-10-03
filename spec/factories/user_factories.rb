require 'factory_girl_rails'

FactoryGirl.define do
  factory :any_user, class: User do
    sequence(:username) {|n| "user#{n}" }
    password  "123456"
    password_confirmation "123456"
    email {|u| "#{u.username}@goalnect.com"   }
    # required if the Devise Confirmable module is used
    confirmed_at DateTime.now
    screen_name {|u| "#{u.username} Screen Name"  }
    dob 27.years.ago
    country_id Country::AUSTRALIA.id
  end
end 
