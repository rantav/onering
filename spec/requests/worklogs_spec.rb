require 'spec_helper'

describe "Worklogs" do
  describe "GET /worklogs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get worklogs_path
      response.status.should be(200)
    end
  end
end
