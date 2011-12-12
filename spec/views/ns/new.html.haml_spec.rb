require 'spec_helper'

describe "ns/new.html.haml" do
  before(:each) do
    assign(:n, stub_model(N,
      :index => 1
    ).as_new_record)
  end

  it "renders new n form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ns_path, :method => "post" do
      assert_select "input#n_index", :name => "n[index]"
    end
  end
end
