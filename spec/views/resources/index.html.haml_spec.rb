require 'spec_helper'

describe "resources/index.html.haml" do
  before(:each) do
    assign(:resources, [
      stub_model(Resource,
        :name => "Name"
      ),
      stub_model(Resource,
        :name => "Name"
      )
    ])
  end

  it "renders a list of resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
