require "spec_helper"

describe PhysicalRacksController do
  describe "routing" do

    it "routes to #index" do
      get("/physical_racks").should route_to("physical_racks#index")
    end

    it "routes to #new" do
      get("/physical_racks/new").should route_to("physical_racks#new")
    end

    it "routes to #show" do
      get("/physical_racks/1").should route_to("physical_racks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/physical_racks/1/edit").should route_to("physical_racks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/physical_racks").should route_to("physical_racks#create")
    end

    it "routes to #update" do
      put("/physical_racks/1").should route_to("physical_racks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/physical_racks/1").should route_to("physical_racks#destroy", :id => "1")
    end

  end
end
