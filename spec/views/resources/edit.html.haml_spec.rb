require 'spec_helper'

describe "resources/edit.html.haml" do
  before(:each) do
    @resource = assign(:resource, stub_model(Resource,
      :name => "MyString"
    ))
  end

  it "renders the edit resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => resources_path(@resource), :method => "post" do
      assert_select "input#resource_name", :name => "resource[name]"
    end
  end
end
