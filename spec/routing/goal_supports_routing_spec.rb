require "spec_helper"

describe GoalSupportsController do
  describe "routing" do

    it "routes to #index" do
      get("/goal_supports").should route_to("goal_supports#index")
    end

    it "routes to #new" do
      get("/goal_supports/new").should route_to("goal_supports#new")
    end

    it "routes to #show" do
      get("/goal_supports/1").should route_to("goal_supports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/goal_supports/1/edit").should route_to("goal_supports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/goal_supports").should route_to("goal_supports#create")
    end

    it "routes to #update" do
      put("/goal_supports/1").should route_to("goal_supports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/goal_supports/1").should route_to("goal_supports#destroy", :id => "1")
    end

  end
end
