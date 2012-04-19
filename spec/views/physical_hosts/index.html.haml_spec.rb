require 'spec_helper'

describe "physical_hosts/index.html.haml" do
  before(:each) do
    assign(:physical_hosts, Kaminari.paginate_array([
      stub_model(PhysicalHost,
        :name => "Name",
        :serial => "Serial",
      ),
      stub_model(PhysicalHost,
        :name => "Name",
        :serial => "Serial",
      )
    ]).page(1))
  end

  it "renders a list of physical_hosts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Serial".to_s, :count => 2
  end
end
