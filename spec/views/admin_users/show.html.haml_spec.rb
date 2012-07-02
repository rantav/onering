require 'spec_helper'

describe "admin_users/show.html.haml" do
  before(:each) do
    @admin_user = assign(:admin_user, stub_model(AdminUser,
      :username => "Username",
      :can_write => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
