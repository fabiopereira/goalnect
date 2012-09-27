require "spec_helper"

describe GoalCommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/goal_comments").should route_to("goal_comments#index")
    end

    it "routes to #new" do
      get("/goal_comments/new").should route_to("goal_comments#new")
    end

    it "routes to #show" do
      get("/goal_comments/1").should route_to("goal_comments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/goal_comments/1/edit").should route_to("goal_comments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/goal_comments").should route_to("goal_comments#create")
    end

    it "routes to #update" do
      put("/goal_comments/1").should route_to("goal_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/goal_comments/1").should route_to("goal_comments#destroy", :id => "1")
    end

  end
end
