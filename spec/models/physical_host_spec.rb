require 'spec_helper'

describe PhysicalHost do
  describe "fqdn" do
    it "is correct" do
      dc = Datacenter.new(:name => 'dc_nane')
      rack = PhysicalRack.new(:datacenter => dc)
      PhysicalHost.new(:name => "1", :physical_rack => rack).fqdn.should == "1.dc_nane"
    end
  end
end
