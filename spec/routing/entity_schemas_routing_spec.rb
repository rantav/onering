require "spec_helper"

describe EntitySchemasController do
  describe "routing" do

    it "routes to #index" do
      get("/entity_schemas").should route_to("entity_schemas#index")
    end

    it "routes to #new" do
      get("/entity_schemas/new").should route_to("entity_schemas#new")
    end

    it "routes to #show" do
      get("/entity_schemas/1").should route_to("entity_schemas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/entity_schemas/1/edit").should route_to("entity_schemas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/entity_schemas").should route_to("entity_schemas#create")
    end

    it "routes to #update" do
      put("/entity_schemas/1").should route_to("entity_schemas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/entity_schemas/1").should route_to("entity_schemas#destroy", :id => "1")
    end

  end
end
