require 'spec_helper'

describe "us/edit.html.haml" do
  before(:each) do
    @u = assign(:u, stub_model(U,
      :index => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit u form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => us_path(@u), :method => "post" do
      assert_select "input#u_index", :name => "u[index]"
      assert_select "input#u_name", :name => "u[name]"
    end
  end
end
