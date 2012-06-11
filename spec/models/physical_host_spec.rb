require 'spec_helper'

describe PhysicalHost do
  describe "fqdn" do
    it "is correct" do
      dc = Datacenter.new(:name => 'nydc1')
      rack = PhysicalRack.new(:datacenter => dc)
      PhysicalHost.new(:name => "1", :physical_rack => rack).fqdn.should == "1.nydc1"
    end
  end

  describe "geometry" do
    it "is correct for a simple host" do
      rack = PhysicalRack.new(:name => 'LGA4.R5.U34')
      PhysicalHost.new(:ob_name => "OB1234", :physical_rack => rack).geometry.should == "LGA4.R5.U34:OB1234"
    end
    it "is correct for a Chassis child host" do
      rack = PhysicalRack.new(:name => 'LGA4.R5.U23')
      chassis = PhysicalHost.new(:name => 'CHASSIS13', :physical_rack => rack)
      PhysicalHost.new(:ob_name => "OB1234", :parent_host => chassis, :n => 4).geometry.should == "LGA4.R5.U23.C13.N4:OB1234"
    end
  end

  describe "short_name" do
    it "is correct" do
      PhysicalHost.new(:name => 'CHASSIS13').short_name.should == 'C13'
    end
  end

  describe "ip_address" do
    it "returns the ip address when there's data from chef" do
      h = PhysicalHost.new
      h.chef_info = ChefInfo.new(ipaddress: "127.0.0.1")
      h.ip_address.should == "127.0.0.1"
    end
    it "returns nil when there's no data from chef" do
      PhysicalHost.new.ip_address.should be(nil)
    end
  end
end
