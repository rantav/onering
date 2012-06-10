require "spec_helper"

describe WorklogsController do
  describe "routing" do

    it "routes to #index" do
      get("/worklogs").should route_to("worklogs#index")
    end

    it "routes to #show" do
      get("/worklogs/1").should route_to("worklogs#show", :id => "1")
    end
  end
end
