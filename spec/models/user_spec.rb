require 'spec_helper'

describe User do
  
  it 'should return full url' do
    user = FactoryGirl.build(:any_user, username: "camilahayashi")
    user.full_url.should be == "/camilahayashi"
  end

  it 'should create a valid user' do
    FactoryGirl.create(:any_user)
    FactoryGirl.create(:any_user)
  end

end