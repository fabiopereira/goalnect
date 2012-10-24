require 'factory_girl_rails'
                      
FactoryGirl.define do
  factory :any_user, class: User do
    sequence(:username) {|n| "username#{n}" }
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


FactoryGirl.define do
  factory :goal, class: Goal do
    sequence(:title) {|n| "Goal #{n}" }    
    description {|g| "My Goal is to complete #{g.title}, blah blah" }    
    due_on 10.days.from_now
    owner {|g| FactoryGirl.create(:any_user)}
    achiever {|g| g.owner }    
    charity {|g| FactoryGirl.create(:active_charity)}
    target_amount Random.rand(100..1000)
    goal_stage_id GoalStage::JUST_STARTED.id
  end
end 

FactoryGirl.define do
  factory :goal_donation, class: GoalDonation do
    amount Random.rand(20..1000)
    goal {|gd| FactoryGirl.create(:goal) }
    message "xpto"
    user {|gd| FactoryGirl.create(:any_user) }
    donor_name {|gd| gd.user.screen_name} 
  end
end 

