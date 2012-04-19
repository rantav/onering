require 'spec_helper'

describe "physical_hosts/show.html.haml" do
  before(:each) do
    @physical_host = assign(:physical_host, stub_model(PhysicalHost,
      :name => "Name",
      :r => 1,
      :u => 1,
      :serial => "Serial",
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/1/)
    rendered.should match(/Serial/)
  end
end
