require 'spec_helper'

describe "audits/index.html.haml" do
  before(:each) do
    assign(:audits, [
      stub_model(Audit,
        :source => "Source",
        :action => "Action"
      ),
      stub_model(Audit,
        :source => "Source",
        :action => "Action"
      )
    ])
  end

  it "renders a list of audits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Action".to_s, :count => 2
  end
end
