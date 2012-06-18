require 'spec_helper'

def valid_host_attributes
  {
    name: "host name",
    n: 0,
    u: 0
  }
end

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

  describe "mac_addresses" do
    describe "when there's data from chef" do
      before(:each) do
        @host = PhysicalHost.new
        @host.chef_info = ChefInfo.new(
           "network"=>
            {"default_interface"=>"eth0",
             "interfaces"=>
              {"eth0"=>
                {"lladdr"=>"00:A0:D1:EE:CA:D0",
                 "inet"=>"192.168.254.183",
                 "inet6"=>"fe80::2a0:d1ff:feee:cad0"},
               "eth1"=>{"lladdr"=>"00:A0:D1:EE:CA:D1"}}})
      end
      it "should return the correct mac_addresses" do
        @host.mac_addresses.should == ["00:A0:D1:EE:CA:D0", "00:A0:D1:EE:CA:D1"]
      end
      it "shoudl return the corrent mac_addresses_display" do
        @host.mac_addresses_display.should == "[\"00:A0:D1:EE:CA:D0\", \"00:A0:D1:EE:CA:D1\"]"
      end
    end
    describe "When there's no data from chef" do
      it "should return nil" do
        PhysicalHost.new.mac_addresses.should be(nil)
      end
      it "mac_addresses_display should return 'No data from chef'" do
        PhysicalHost.new.mac_addresses_display.should == "No data from chef"
      end
    end
  end

  describe "all_ip_addresses" do
    before :each do
      PhysicalHost.all.delete
    end
    describe "where there are no hosts in the db" do
      it "should collect none" do
        PhysicalHost.all_ip_addresses.should == []
      end
    end
    describe "when there are hosts but no IP addresses" do
      before :each do
        PhysicalHost.create!(valid_host_attributes)
      end
      it "should collect none" do
        PhysicalHost.all_ip_addresses.should == []
      end
    end
    describe "when there are hosts and they have IP addresses" do
      before :each do
        PhysicalHost.create!(valid_host_attributes.merge(chef_info: ChefInfo.new(ipaddress: "127.0.0.1")))
        PhysicalHost.create!(valid_host_attributes.merge(chef_info: ChefInfo.new(ipaddress: "128.0.0.1")))
      end
      it "should collect all ip addresses" do
        PhysicalHost.all_ip_addresses.should == ["127.0.0.1", "128.0.0.1"]
      end
    end
  end
end
