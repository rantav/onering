require 'spec_helper'

describe "settings/show.html.haml" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Api Ro Username/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Api Ro Password/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Api Rw Username/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Api Rw Password/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Glu User/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Glu Pass/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Glu Host And Port/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Glu Fabric/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Chef Server/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Chef Pem File/)
  end
end
