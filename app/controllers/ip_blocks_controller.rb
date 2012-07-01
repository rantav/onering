class IpBlocksController < ApplicationController
  layout 'wide'
  load_and_authorize_resource
  
  # GET /ip_blocks
  # GET /ip_blocks.json
  def index
    @ip_blocks = IpBlock.all.to_a
    all_ip_addresses = PhysicalHost.all_ip_addresses
    @ip_blocks.each do |ip_block|
      ip_block[:free_addresses] = ip_block.next_free_addresses(ip_block.start, 5, all_ip_addresses)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ip_blocks }
    end
  end

  # GET /ip_blocks/1
  # GET /ip_blocks/1.json
  def show
    @ip_block = IpBlock.find(params[:id])
    @available_ips = @ip_block.next_addresses(@ip_block.start, params[:count] || 50, PhysicalHost.all_ip_addresses)
    @ip_block[:available_ips] = @available_ips
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ip_block }
    end
  end

  # GET /ip_blocks/new
  # GET /ip_blocks/new.json
  def new
    @ip_block = IpBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ip_block }
    end
  end

  # GET /ip_blocks/1/edit
  def edit
    @ip_block = IpBlock.find(params[:id])
  end

  # POST /ip_blocks
  # POST /ip_blocks.json
  def create
    @ip_block = IpBlock.new(params[:ip_block])

    respond_to do |format|
      if @ip_block.save
        format.html { redirect_to @ip_block, notice: 'Ip block was successfully created.' }
        format.json { render json: @ip_block, status: :created, location: @ip_block }
      else
        format.html { render action: "new" }
        format.json { render json: @ip_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ip_blocks/1
  # PUT /ip_blocks/1.json
  def update
    @ip_block = IpBlock.find(params[:id])

    respond_to do |format|
      if @ip_block.update_attributes(params[:ip_block])
        format.html { redirect_to @ip_block, notice: 'Ip block was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ip_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ip_blocks/1
  # DELETE /ip_blocks/1.json
  def destroy
    @ip_block = IpBlock.find(params[:id])
    @ip_block.destroy

    respond_to do |format|
      format.html { redirect_to ip_blocks_url }
      format.json { head :ok }
    end
  end
end
