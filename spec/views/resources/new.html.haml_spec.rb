require 'spec_helper'

describe "resources/new.html.haml" do
  before(:each) do
    assign(:resource, stub_model(Resource,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => resources_path, :method => "post" do
      assert_select "input#resource_name", :name => "resource[name]"
    end
  end
end
