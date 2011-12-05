require 'spec_helper'

describe "physical_hosts/edit.html.haml" do
  before(:each) do
    @physical_host = assign(:physical_host, stub_model(PhysicalHost,
      :name => "MyString",
      :r => 1,
      :u => 1,
      :n => 1,
      :type => "",
      :serial => "MyString",
      :pdu1 => "MyString",
      :pdu2 => "MyString",
      :label => "MyString",
      :status => "MyString",
      :notes => "MyString"
    ))
  end

  it "renders the edit physical_host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => physical_hosts_path(@physical_host), :method => "post" do
      assert_select "input#physical_host_name", :name => "physical_host[name]"
      assert_select "input#physical_host_r", :name => "physical_host[r]"
      assert_select "input#physical_host_u", :name => "physical_host[u]"
      assert_select "input#physical_host_n", :name => "physical_host[n]"
      assert_select "input#physical_host_type", :name => "physical_host[type]"
      assert_select "input#physical_host_serial", :name => "physical_host[serial]"
      assert_select "input#physical_host_pdu1", :name => "physical_host[pdu1]"
      assert_select "input#physical_host_pdu2", :name => "physical_host[pdu2]"
      assert_select "input#physical_host_label", :name => "physical_host[label]"
      assert_select "input#physical_host_status", :name => "physical_host[status]"
      assert_select "input#physical_host_notes", :name => "physical_host[notes]"
    end
  end
end