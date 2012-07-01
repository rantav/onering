require 'spec_helper'

describe "settings/index.html.haml" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        :api_ro_username => "Api Ro Username",
        :api_ro_password => "Api Ro Password",
        :api_rw_username => "Api Rw Username",
        :api_rw_password => "Api Rw Password",
        :glu_enabled => false,
        :glu_user => "Glu User",
        :glu_pass => "Glu Pass",
        :glu_host_and_port => "Glu Host And Port",
        :glu_fabric => "Glu Fabric",
        :chef_enabled => false,
        :chef_server => "Chef Server",
        :chef_pem_file => "Chef Pem File"
      ),
      stub_model(Setting,
        :api_ro_username => "Api Ro Username",
        :api_ro_password => "Api Ro Password",
        :api_rw_username => "Api Rw Username",
        :api_rw_password => "Api Rw Password",
        :glu_enabled => false,
        :glu_user => "Glu User",
        :glu_pass => "Glu Pass",
        :glu_host_and_port => "Glu Host And Port",
        :glu_fabric => "Glu Fabric",
        :chef_enabled => false,
        :chef_server => "Chef Server",
        :chef_pem_file => "Chef Pem File"
      )
    ])
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Api Ro Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Api Ro Password".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Api Rw Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Api Rw Password".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Glu User".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Glu Pass".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Glu Host And Port".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Glu Fabric".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Chef Server".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Chef Pem File".to_s, :count => 2
  end
end
