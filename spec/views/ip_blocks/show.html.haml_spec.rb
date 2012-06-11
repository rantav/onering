require 'spec_helper'

describe "ip_blocks/show.html.haml" do
  before(:each) do
    @ip_block = assign(:ip_block, stub_model(IpBlock,
      :base => 1,
      :mask => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
