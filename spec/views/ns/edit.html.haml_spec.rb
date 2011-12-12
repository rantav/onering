require 'spec_helper'

describe "ns/edit.html.haml" do
  before(:each) do
    @n = assign(:n, stub_model(N,
      :index => 1
    ))
  end

  it "renders the edit n form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ns_path(@n), :method => "post" do
      assert_select "input#n_index", :name => "n[index]"
    end
  end
end
