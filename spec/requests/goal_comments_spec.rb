require 'spec_helper'

describe "GoalComments" do
  describe "GET /goal_comments" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get goal_comments_path
      response.status.should be(200)
    end
  end
end
