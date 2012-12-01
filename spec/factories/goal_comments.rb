# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal_comment do
    goal_id 1
    user_id 1
    message "MyText"
  end
end
