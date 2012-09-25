require 'spec_helper'

describe GoalsController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end


    it     "should create goal and goal_user" do
          post :create, :goal => {} @user.username
          response.should be_success
        end
  
end