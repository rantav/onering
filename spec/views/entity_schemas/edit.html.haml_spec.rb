require 'spec_helper'

describe "entity_schemas/edit.html.haml" do
  before(:each) do
    @entity_schema = assign(:entity_schema, stub_model(EntitySchema,
      :name => "MyString",
    ))
  end

  it "renders the edit entity_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_schemas_path(@entity_schema), :method => "post" do
      assert_select "input#entity_schema_name", :name => "entity_schema[name]"
    end
  end
end
