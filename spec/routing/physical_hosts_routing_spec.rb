require "spec_helper"

describe PhysicalHostsController do
  describe "routing" do

    it "routes to #index" do
      get("/physical_hosts").should route_to("physical_hosts#index")
    end

    it "routes to #new" do
      get("/physical_hosts/new").should route_to("physical_hosts#new")
    end

    it "routes to #show" do
      get("/physical_hosts/1").should route_to("physical_hosts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/physical_hosts/1/edit").should route_to("physical_hosts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/physical_hosts").should route_to("physical_hosts#create")
    end

    it "routes to #update" do
      put("/physical_hosts/1").should route_to("physical_hosts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/physical_hosts/1").should route_to("physical_hosts#destroy", :id => "1")
    end

  end
end
