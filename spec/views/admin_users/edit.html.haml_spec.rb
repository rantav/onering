require 'spec_helper'

describe "admin_users/edit.html.haml" do
  before(:each) do
    @admin_user = assign(:admin_user, stub_model(AdminUser,
      :username => "MyString",
      :can_write => false
    ))
  end

  it "renders the edit admin_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_users_path(@admin_user), :method => "post" do
      assert_select "input#admin_user_can_write", :name => "admin_user[can_write]"
    end
  end
end
