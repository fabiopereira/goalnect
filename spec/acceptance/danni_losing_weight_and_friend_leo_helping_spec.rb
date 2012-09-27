require 'acceptance/acceptance_helper'

feature 'Danni losing weight and friend leo helping', %q{
  In order to ...
  As a ...
  I want ...
} do

  scenario 'first scenario' do
    true.should == true
    visit '/'
    page.should have_content 'Login'
  end

end
