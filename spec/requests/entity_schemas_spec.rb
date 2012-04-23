require 'spec_helper'

describe "EntitySchemas" do
  describe "GET /entity_schemas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get entity_schemas_path
      response.status.should be(200)
    end
  end
end
