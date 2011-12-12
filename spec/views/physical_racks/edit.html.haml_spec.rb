require 'spec_helper'

describe "physical_racks/edit.html.haml" do
  before(:each) do
    @physical_rack = assign(:physical_rack, stub_model(PhysicalRack,
      :index => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit physical_rack form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => physical_racks_path(@physical_rack), :method => "post" do
      assert_select "input#physical_rack_index", :name => "physical_rack[index]"
      assert_select "input#physical_rack_name", :name => "physical_rack[name]"
    end
  end
end
