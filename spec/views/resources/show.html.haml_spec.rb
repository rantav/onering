require 'spec_helper'

describe "resources/show.html.haml" do
  before(:each) do
    @resource = assign(:resource, stub_model(Resource,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
