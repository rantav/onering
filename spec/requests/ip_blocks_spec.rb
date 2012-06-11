require 'spec_helper'

describe "IpBlocks" do
  describe "GET /ip_blocks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get ip_blocks_path
      response.status.should be(200)
    end
  end
end
