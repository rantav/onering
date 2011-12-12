require 'spec_helper'

describe "ns/index.html.haml" do
  before(:each) do
    assign(:ns, [
      stub_model(N,
        :index => 1
      ),
      stub_model(N,
        :index => 1
      )
    ])
  end

  it "renders a list of ns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
