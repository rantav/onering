require 'spec_helper'

describe "ip_blocks/edit.html.haml" do
  before(:each) do
    @ip_block = assign(:ip_block, stub_model(IpBlock,
      :base => 1,
      :mask => 1
    ))
  end

  it "renders the edit ip_block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ip_blocks_path(@ip_block), :method => "post" do
      assert_select "input#ip_block_base_address_str", :name => "ip_block[base_address_str]"
      assert_select "input#ip_block_mask", :name => "ip_block[mask]"
    end
  end
end
