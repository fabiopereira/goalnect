require "spec_helper"

describe GoalDonationsController do
  describe "routing" do

    it "routes to #index" do
      get("/goal_donations").should route_to("goal_donations#index")
    end

    it "routes to #new" do
      get("/goal_donations/new").should route_to("goal_donations#new")
    end

    it "routes to #show" do
      get("/goal_donations/1").should route_to("goal_donations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/goal_donations/1/edit").should route_to("goal_donations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/goal_donations").should route_to("goal_donations#create")
    end

    it "routes to #update" do
      put("/goal_donations/1").should route_to("goal_donations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/goal_donations/1").should route_to("goal_donations#destroy", :id => "1")
    end

  end
end
