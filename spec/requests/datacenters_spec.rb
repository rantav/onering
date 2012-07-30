require 'spec_helper'

describe "Datacenters" do
  before :each do
    datacenter = mock_model(Datacenter, {name: 'n', provider_name: 'p', location: 'l', contact_info: 'i', support_link: 's', support_email: 'e', support_phone: 'p'})
    Datacenter.stub(:all) {[datacenter]}
  end
  describe "GET /datacenters" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get datacenters_path
      response.status.should be(200)
    end
  end
end
