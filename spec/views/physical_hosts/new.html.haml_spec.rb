require 'spec_helper'

describe "physical_hosts/new.html.haml" do
  before(:each) do
    physical_host = PhysicalHost.new({
      :name => "MyString",
      :serial => "MyString"
    })
    assign(:physical_host, physical_host)
  end

  it "renders new physical_host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => physical_hosts_path, :method => "post" do
      assert_select "input#physical_host_name", :name => "physical_host[name]"
      assert_select "input#physical_host_serial", :name => "physical_host[serial]"
    end
  end
end
