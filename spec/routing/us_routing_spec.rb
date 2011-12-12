require "spec_helper"

describe UsController do
  describe "routing" do

    it "routes to #index" do
      get("/us").should route_to("us#index")
    end

    it "routes to #new" do
      get("/us/new").should route_to("us#new")
    end

    it "routes to #show" do
      get("/us/1").should route_to("us#show", :id => "1")
    end

    it "routes to #edit" do
      get("/us/1/edit").should route_to("us#edit", :id => "1")
    end

    it "routes to #create" do
      post("/us").should route_to("us#create")
    end

    it "routes to #update" do
      put("/us/1").should route_to("us#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/us/1").should route_to("us#destroy", :id => "1")
    end

  end
end
