# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal_donation do
    message ""
    goal_id ""
    user_id ""
    amount "9.99"
  end
end
