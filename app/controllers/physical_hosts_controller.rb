
class PhysicalHostsController < ApplicationController

  respond_to :html, :json

  # GET /physical_hosts
  # GET /physical_hosts.json
  def index
    @physical_hosts = PhysicalHost.page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @physical_hosts }
    end
  end
  
  # GET /physical_hosts
  # GET /physical_hosts.json
  def search
    @physical_hosts = PhysicalHost.search(params[:q])

    respond_to do |format|
      format.html { render :index}
      format.json { render json: @physical_hosts }
    end
  end

  # GET /physical_hosts/1
  # GET /physical_hosts/1.json
  def show
    @physical_host = PhysicalHost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @physical_host }
    end
  end

  # GET /physical_hosts/new
  # GET /physical_hosts/new.json
  def new
    @physical_host = PhysicalHost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @physical_host }
    end
  end

  # GET /physical_hosts/1/edit
  def edit
    @physical_host = PhysicalHost.find(params[:id])
  end

  # POST /physical_hosts
  # POST /physical_hosts.json
  def create
    @physical_host = PhysicalHost.new(params[:physical_host])

    respond_to do |format|
      if @physical_host.save
        format.html { redirect_to @physical_host, notice: 'Physical host was successfully created.' }
        format.json { render json: @physical_host, status: :created, location: @physical_host }
      else
        format.html { render action: "new" }
        format.json { render json: @physical_host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /physical_hosts/1
  # PUT /physical_hosts/1.json
  def update
    @physical_host = PhysicalHost.find(params[:id])
    @physical_host.update_attributes(params[:physical_host])
    respond_with @physical_host
  end

  # DELETE /physical_hosts/1
  # DELETE /physical_hosts/1.json
  def destroy
    @physical_host = PhysicalHost.find(params[:id])
    @physical_host.destroy

    respond_to do |format|
      format.html { redirect_to physical_hosts_url }
      format.json { head :ok }
    end
  end
end
