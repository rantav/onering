class AuditsController < ApplicationController
  layout "wide"
  load_and_authorize_resource
  # GET /audits
  # GET /audits.json
  def index
    @audits = Audit.order_by({created_at: -1}).page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end
end
