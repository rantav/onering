require 'spec_helper'

describe "ip_blocks/index.html.haml" do
  before(:each) do
    assign(:ip_blocks, [
      stub_model(IpBlock,
        :base_address => 2130706433,
        :mask => 32
      ),
      stub_model(IpBlock,
        :base_address => 2130706433,
        :mask => 32
      )
    ])
  end

  it "renders a list of ip_blocks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "127.0.0.1/32", :count => 2
  end
end
