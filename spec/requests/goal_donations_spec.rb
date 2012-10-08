require 'spec_helper'

describe "GoalDonations" do
  describe "GET /goal_donations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get goal_donations_path
      response.status.should be(200)
    end
  end
end
