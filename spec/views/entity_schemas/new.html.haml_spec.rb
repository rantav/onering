require 'spec_helper'

describe "entity_schemas/new.html.haml" do
  before(:each) do
    assign(:entity_schema, stub_model(EntitySchema,
      :name => "MyString",
      :new? => false
    ).as_new_record)
  end

  it "renders new entity_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_schemas_path, :method => "post" do
      assert_select "input#entity_schema_name", :name => "entity_schema[name]"
    end
  end
end
