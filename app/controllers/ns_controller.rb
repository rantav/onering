class NsController < ApplicationController
  # GET /ns
  # GET /ns.json
  def index
    @ns = N.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ns }
    end
  end

  # GET /ns/1
  # GET /ns/1.json
  def show
    @n = N.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @n }
    end
  end

  # GET /ns/new
  # GET /ns/new.json
  def new
    @n = N.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @n }
    end
  end

  # GET /ns/1/edit
  def edit
    @n = N.find(params[:id])
  end

  # POST /ns
  # POST /ns.json
  def create
    @n = N.new(params[:n])

    respond_to do |format|
      if @n.save
        format.html { redirect_to @n, notice: 'N was successfully created.' }
        format.json { render json: @n, status: :created, location: @n }
      else
        format.html { render action: "new" }
        format.json { render json: @n.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ns/1
  # PUT /ns/1.json
  def update
    @n = N.find(params[:id])

    respond_to do |format|
      if @n.update_attributes(params[:n])
        format.html { redirect_to @n, notice: 'N was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @n.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ns/1
  # DELETE /ns/1.json
  def destroy
    @n = N.find(params[:id])
    @n.destroy

    respond_to do |format|
      format.html { redirect_to ns_url }
      format.json { head :ok }
    end
  end
end
