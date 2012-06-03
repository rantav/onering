require 'spec_helper'

describe "audits/new.html.haml" do
  before(:each) do
    assign(:audit, stub_model(Audit,
      :source => "MyString",
      :action => "MyString"
    ).as_new_record)
  end

  it "renders new audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path, :method => "post" do
      assert_select "input#audit_source", :name => "audit[source]"
      assert_select "input#audit_action", :name => "audit[action]"
    end
  end
end
