require 'spec_helper'

describe "settings/edit.html.haml" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
      :api_ro_username => "MyString",
      :api_ro_password => "MyString",
      :api_rw_username => "MyString",
      :api_rw_password => "MyString",
      :glu_enabled => false,
      :glu_user => "MyString",
      :glu_pass => "MyString",
      :glu_host_and_port => "MyString",
      :glu_fabric => "MyString",
      :chef_enabled => false,
      :chef_server => "MyString",
      :chef_pem_file => "MyString"
    ))
  end

  it "renders the edit setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => settings_path(@setting), :method => "post" do
      assert_select "input#setting_api_ro_username", :name => "setting[api_ro_username]"
      assert_select "input#setting_api_ro_password", :name => "setting[api_ro_password]"
      assert_select "input#setting_api_rw_username", :name => "setting[api_rw_username]"
      assert_select "input#setting_api_rw_password", :name => "setting[api_rw_password]"
      assert_select "input#setting_glu_enabled", :name => "setting[glu_enabled]"
      assert_select "input#setting_glu_user", :name => "setting[glu_user]"
      assert_select "input#setting_glu_pass", :name => "setting[glu_pass]"
      assert_select "input#setting_glu_host_and_port", :name => "setting[glu_host_and_port]"
      assert_select "input#setting_glu_fabric", :name => "setting[glu_fabric]"
      assert_select "input#setting_chef_enabled", :name => "setting[chef_enabled]"
      assert_select "input#setting_chef_server", :name => "setting[chef_server]"
      assert_select "input#setting_chef_pem_file", :name => "setting[chef_pem_file]"
    end
  end
end
