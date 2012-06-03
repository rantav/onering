require 'spec_helper'

describe "audits/show.html.haml" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit,
      :source => "Source",
      :action => "Action"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Source/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Action/)
  end
end
