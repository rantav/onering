require 'spec_helper'

describe "physical_racks/show.html.haml" do
  before(:each) do
    @physical_rack = assign(:physical_rack, stub_model(PhysicalRack,
      :index => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
