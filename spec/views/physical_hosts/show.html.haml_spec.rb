require 'spec_helper'

describe "physical_hosts/show.html.haml" do
  before(:each) do
    @physical_host = assign(:physical_host, stub_model(PhysicalHost,
      :name => "Name",
      :r => 1,
      :u => 1,
      :n => 1,
      :type => "Type",
      :serial => "Serial",
      :pdu1 => "Pdu1",
      :pdu2 => "Pdu2",
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Serial/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pdu1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Pdu2/)
  end
end
