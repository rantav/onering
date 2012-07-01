class PhysicalHostsController < ApplicationController

  respond_to :html, :json

  layout "wide"
  load_and_authorize_resource unless Rails.env == 'test'

  autocomplete :physical_host, :name, :display_value => :fqdn, :limit => 100

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
    @physical_hosts = PhysicalHost.search(params[:q]).page params[:page]
    respond_to do |format|
      format.html { render :index}
      format.json { render json: @physical_hosts }
    end
  end

  # GET /physical_hosts/1
  # GET /physical_hosts/1.json
  def show
    id = params[:id]
    @physical_host = PhysicalHost.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @schema = self.schema
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
    id = params[:id]
    @physical_host = PhysicalHost.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @schema = self.schema
    if params[:add_pdu]
      @physical_host.pdus.build
    end
  end

  # POST /physical_hosts
  # POST /physical_hosts.json
  def create
    @physical_host = PhysicalHost.new(params[:physical_host])
    @physical_host.audits << Audit.new(source: 'controller', action: 'create', admin_user: current_user) # Why this no work???
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
    id = params[:id]
    @physical_host = PhysicalHost.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @physical_host.attributes = params[:physical_host]
    @physical_host.audits << Audit.new(source: 'controller', action: 'update', admin_user: current_user)
    respond_to do |format|
      if @physical_host.save
        format.html { redirect_to @physical_host, notice: 'Physical host was successfully updated.' }
        format.json { respond_with_bip(@physical_host) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@physical_host) }
      end
    end
  end

  # DELETE /physical_hosts/1
  # DELETE /physical_hosts/1.json
  def destroy
    id = params[:id]
    @physical_host = PhysicalHost.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @physical_host.destroy

    respond_to do |format|
      format.html { redirect_to physical_hosts_url }
      format.json { head :ok }
    end
  end

  def schema
    EntitySchema.first(conditions: {name: 'physical_host'})
  end
end
