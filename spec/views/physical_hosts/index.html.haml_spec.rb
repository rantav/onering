require 'spec_helper'

describe "physical_hosts/index.html.haml" do
  before(:each) do
    assign(:physical_hosts, [
      stub_model(PhysicalHost,
        :name => "Name",
        :r => 1,
        :u => 1,
        :n => 1,
        :type => "Type",
        :serial => "Serial",
        :pdu1 => "Pdu1",
        :pdu2 => "Pdu2",
        :label => "Label",
        :status => "Status",
        :notes => "Notes"
      ),
      stub_model(PhysicalHost,
        :name => "Name",
        :r => 1,
        :u => 1,
        :n => 1,
        :type => "Type",
        :serial => "Serial",
        :pdu1 => "Pdu1",
        :pdu2 => "Pdu2",
        :label => "Label",
        :status => "Status",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of physical_hosts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Serial".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Pdu1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Pdu2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
