class EntitySchemasController < ApplicationController

  layout 'wide'
  load_and_authorize_resource
  
  # GET /entity_schemas
  # GET /entity_schemas.json
  def index
    @entity_schemas = EntitySchema.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entity_schemas }
    end
  end

  # GET /entity_schemas/1
  # GET /entity_schemas/1.json
  def show
    @entity_schema = EntitySchema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity_schema }
    end
  end

  # GET /entity_schemas/new
  # GET /entity_schemas/new.json
  def new
    @entity_schema = EntitySchema.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity_schema }
    end
  end

  # GET /entity_schemas/1/edit
  def edit
    @entity_schema = EntitySchema.find(params[:id])
  end

  # POST /entity_schemas
  # POST /entity_schemas.json
  def create
    @entity_schema = EntitySchema.new(params[:entity_schema])

    respond_to do |format|
      if @entity_schema.save
        format.html { redirect_to @entity_schema, notice: 'Entity schema was successfully created.' }
        format.json { render json: @entity_schema, status: :created, location: @entity_schema }
      else
        format.html { render action: "new" }
        format.json { render json: @entity_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entity_schemas/1
  # PUT /entity_schemas/1.json
  def update
    @entity_schema = EntitySchema.find(params[:id])

    respond_to do |format|
      if @entity_schema.update_attributes(params[:entity_schema])
        format.html { redirect_to @entity_schema, notice: 'Entity schema was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @entity_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_schemas/1
  # DELETE /entity_schemas/1.json
  def destroy
    @entity_schema = EntitySchema.find(params[:id])
    @entity_schema.destroy

    respond_to do |format|
      format.html { redirect_to entity_schemas_url }
      format.json { head :ok }
    end
  end
end
