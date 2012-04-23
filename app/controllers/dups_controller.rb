class DupsController < ApplicationController

  layout "wide"

  # GET /dups
  # GET /dups.json
  def index
    all = {}
    PhysicalHost.all.each {|h| all[h.name] ? all[h.name]<<h.id.to_s : all[h.name] = [h.id.to_s]}
    
    @dups = all.reject {|k,v| v.length < 2}
    @dups = @dups.map {|k,v| {:name => k, :links => v.map {|i| '/physical_hosts/' + i}}}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dups }
    end
  end
end
