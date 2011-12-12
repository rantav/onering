require 'spec_helper'

describe "ns/show.html.haml" do
  before(:each) do
    @n = assign(:n, stub_model(N,
      :index => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
