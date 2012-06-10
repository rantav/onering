require 'spec_helper'

describe "worklogs/show.html.haml" do
  before(:each) do
    @worklog = assign(:worklog, stub_model(Worklog,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
