require 'spec_helper'

describe "entity_schemas/index.html.haml" do
  before(:each) do
    assign(:entity_schemas, [
      stub_model(EntitySchema,
        :name => "Name",
      ),
      stub_model(EntitySchema,
        :name => "Name",
      )
    ])
  end

  it "renders a list of entity_schemas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
