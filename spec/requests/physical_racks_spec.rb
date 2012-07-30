require 'spec_helper'

describe "PhysicalRacks" do
  before :each do
    datacenter = mock_model(Datacenter, {name: 'n'})
    rack = mock_model(PhysicalRack, {index: 1, name: 'n', number_of_us: 5, datacenter: datacenter})
    PhysicalRack.stub(:all) {[rack]}
  end
  describe "GET /physical_racks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get physical_racks_path
      response.status.should be(200)
    end
  end
end
