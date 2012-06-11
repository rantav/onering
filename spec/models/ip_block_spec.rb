require 'spec_helper'

describe IpBlock do
  describe "validations" do
    it "Should be valid with proper base and mask" do
      IpBlock.new(base_address: 203569230, mask: 10).should be_valid
    end
    it "Should not be valid with IP -1" do
      IpBlock.new(base_address: -1).should_not be_valid
    end
    it "Should not be valid with mask > 32" do
      IpBlock.new(base_address: 203569230, mask: 33).should_not be_valid
    end
  end

  describe "display" do
    it "should display IP 12.34.56.78/32" do
      IpBlock.new(base_address: 203569230, mask: 32).display.should == "12.34.56.78/32"
    end
  end

  describe "parse" do
    it "should parse 127.0.0.1" do
      IpBlock.parse("127.0.0.1").display.should == "127.0.0.1/32"
    end
    it "should parse 127.0.0.0/8" do
      IpBlock.parse("127.0.0.1/8").display.should == "127.0.0.0/8"
    end
  end
end
