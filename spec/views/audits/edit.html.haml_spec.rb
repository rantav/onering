require 'spec_helper'

describe "audits/edit.html.haml" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit,
      :source => "MyString",
      :action => "MyString"
    ))
  end

  it "renders the edit audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path(@audit), :method => "post" do
      assert_select "input#audit_source", :name => "audit[source]"
      assert_select "input#audit_action", :name => "audit[action]"
    end
  end
end
