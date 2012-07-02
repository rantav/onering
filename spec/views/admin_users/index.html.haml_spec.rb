require 'spec_helper'

describe "admin_users/index.html.haml" do
  before(:each) do
    assign(:admin_users, [
      stub_model(AdminUser,
        :username => "Username",
        :can_write => false
      ),
      stub_model(AdminUser,
        :username => "Username",
        :can_write => false
      )
    ])
  end

  it "renders a list of admin_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
