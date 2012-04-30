require 'spec_helper'

describe "entity_schemas/show.html.haml" do
  before(:each) do
    @entity_schema = assign(:entity_schema, stub_model(EntitySchema,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
