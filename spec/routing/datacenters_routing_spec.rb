require "spec_helper"

describe DatacentersController do
  describe "routing" do

    it "routes to #index" do
      get("/datacenters").should route_to("datacenters#index")
    end

    it "routes to #new" do
      get("/datacenters/new").should route_to("datacenters#new")
    end

    it "routes to #show" do
      get("/datacenters/1").should route_to("datacenters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/datacenters/1/edit").should route_to("datacenters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/datacenters").should route_to("datacenters#create")
    end

    it "routes to #update" do
      put("/datacenters/1").should route_to("datacenters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/datacenters/1").should route_to("datacenters#destroy", :id => "1")
    end

  end
end
