require 'spec_helper'

describe Country do
  
  it 'should be able to return current Country based on locale' do
    I18n.locale = "pt"
    Country.current_from_locale.should be == Country::BRASIL
  end

end