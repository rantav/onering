require 'spec_helper'

describe "us/new.html.haml" do
  before(:each) do
    assign(:u, stub_model(U,
      :index => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new u form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => us_path, :method => "post" do
      assert_select "input#u_index", :name => "u[index]"
      assert_select "input#u_name", :name => "u[name]"
    end
  end
end
