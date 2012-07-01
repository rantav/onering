class DatacentersController < ApplicationController

  layout "wide"
  load_and_authorize_resource unless Rails.env == 'test'
  
  # GET /datacenters
  # GET /datacenters.json
  def index
    @datacenters = Datacenter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datacenters }
    end
  end

  # GET /datacenters/1
  # GET /datacenters/1.json
  def show
    id = params[:id]
    @datacenter = Datacenter.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @schema = self.schema
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @datacenter }
    end
  end

  # GET /datacenters/new
  # GET /datacenters/new.json
  def new
    @datacenter = Datacenter.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @datacenter }
    end
  end

  # GET /datacenters/1/edit
  def edit
    id = params[:id]
    @datacenter = Datacenter.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @schema = self.schema
  end

  # POST /datacenters
  # POST /datacenters.json
  def create
    @datacenter = Datacenter.new(params[:datacenter])

    respond_to do |format|
      if @datacenter.save
        format.html { redirect_to @datacenter, notice: 'Datacenter was successfully created.' }
        format.json { render json: @datacenter, status: :created, location: @datacenter }
      else
        format.html { render action: "new" }
        format.json { render json: @datacenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /datacenters/1
  # PUT /datacenters/1.json
  def update
    id = params[:id]
    @datacenter = Datacenter.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @datacenter.attributes = params[:datacenter]
    @datacenter.audits << Audit.new(source: 'controller', action: 'update', admin_user: current_admin_user)
    respond_to do |format|
      if @datacenter.save
        format.html { redirect_to @datacenter, notice: 'Datacenter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @datacenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datacenters/1
  # DELETE /datacenters/1.json
  def destroy
    id = params[:id]
    @datacenter = Datacenter.any_of({_id: id}, {name: id.gsub('-', '.')}).first
    @datacenter.destroy

    respond_to do |format|
      format.html { redirect_to datacenters_url }
      format.json { head :ok }
    end
  end

  def schema
    EntitySchema.first(conditions: {name: 'datacenter'})
  end

end
