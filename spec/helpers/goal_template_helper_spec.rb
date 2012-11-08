require 'spec_helper'

describe 'goal template helpers' do
  
  it 'should only show active options for current locale' do
    active_pt_1 = FactoryGirl.create(:goal_template, active: true, locale: :pt)
    active_pt_2 = FactoryGirl.create(:goal_template, active: true, locale: :pt)
    active_en_1 = FactoryGirl.create(:goal_template, active: true, locale: :en)
    
    inactive_pt = FactoryGirl.create(:goal_template, active: true, locale: :pt)
    inactive_en = FactoryGirl.create(:goal_template, active: true, locale: :en)
    # options = active_goal_template_options
  end

end