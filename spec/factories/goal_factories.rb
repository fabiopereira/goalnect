require 'factory_girl_rails'

FactoryGirl.define do
  factory :active_charity, class: Charity do
    sequence(:nickname) {|n| "Charity#{n}"}
    sequence(:charity_name) {|n| "Charity #{n}"}
    contact_name {|c| "Contact #{c.charity_name}"}
    sequence(:email) {|n| "charity#{n}@mycharitydomain.com"}
    phone "2323424234"
    active true
  end
end 

                      
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
    current_stage_id GoalDonationStage::APPROVED.id
  end
end

FactoryGirl.define do
  factory :goal_template, class: GoalTemplate do
    sequence(:title) {|n| "Goal Template #{n}" }
    description {|g| "My Goal is to complete #{g.title}, blah blah" }
    locale Country::AUSTRALIA.locale
    active true
    goal_template_type_id GoalTemplateType::STANDARD.id
  end
end

FactoryGirl.define do
  factory :goal_donation_point_transaction, class: GoalDonationPointTransaction do
    goal_donation {|t| FactoryGirl.create(:goal_donation) }
    goal {|t| t.goal_donation.goal }
    point_amount Random.rand(10..1000)
    user {|t| t.goal.achiever }
    active true
  end
end

