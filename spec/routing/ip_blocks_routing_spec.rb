require "spec_helper"

describe IpBlocksController do
  describe "routing" do

    it "routes to #index" do
      get("/ip_blocks").should route_to("ip_blocks#index")
    end

    it "routes to #new" do
      get("/ip_blocks/new").should route_to("ip_blocks#new")
    end

    it "routes to #show" do
      get("/ip_blocks/1").should route_to("ip_blocks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ip_blocks/1/edit").should route_to("ip_blocks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ip_blocks").should route_to("ip_blocks#create")
    end

    it "routes to #update" do
      put("/ip_blocks/1").should route_to("ip_blocks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ip_blocks/1").should route_to("ip_blocks#destroy", :id => "1")
    end

  end
end
