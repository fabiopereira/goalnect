require 'spec_helper'

describe AchieverController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :view, :user_username => @user.username
      response.should be_success
    end
    
  end

end
