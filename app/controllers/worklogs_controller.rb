class WorklogsController < ApplicationController
  layout "wide"
  load_and_authorize_resource

  # GET /worklogs
  # GET /worklogs.json
  def index
    @worklogs = Worklog.order_by({created_at: -1}).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @worklogs }
    end
  end

  # GET /worklogs/1
  # GET /worklogs/1.json
  def show
    @worklog = Worklog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @worklog }
    end
  end
end
