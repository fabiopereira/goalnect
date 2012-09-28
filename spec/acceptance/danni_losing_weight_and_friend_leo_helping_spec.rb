require 'acceptance/acceptance_helper'

feature 'Danni losing weight and friend leo helping', %q{
  In order for Danni to lose 35kg in 12 months she needs support from her friends
  As a Goalnect Achiever Danni needs to register her goal and ask friends to support and believe that she can achieve it 
} do
  
  scenario 'Danni 12 months journey losing 35kg' do  
    danni = logged_in 'danni'
  end

end
