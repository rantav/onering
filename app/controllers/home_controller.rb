class HomeController < ApplicationController
  def index
    @hosts_count = PhysicalHost.count
    @racks_count = PhysicalRack.count
    @dcs_count = Datacenter.count
    @glu_modules = PhysicalHost.collect_glu_modeuls
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json:  {hosts_count: @hosts_count, racks_count: @racks_count, dcs_count: @dcs_count}}
    end
  end
end
