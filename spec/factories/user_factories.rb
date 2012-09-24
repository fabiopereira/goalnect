require 'factory_girl_rails'

FactoryGirl.define do
  factory :any_user, aliases: [:user, :camila], class: User do
    username 'camilahayashi'
    password  '123456'
    password_confirmation { |u| u.password }
    email {|u| '#{u.username}@goalnect.com' }
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
    screen_name 'Camila Hayashi'
    dob 27.years.ago
    country_id 1
  end
end 