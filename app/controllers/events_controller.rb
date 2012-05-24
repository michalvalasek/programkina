class EventsController < ApplicationController
  
  before_filter :authenticate_user!

  load_resource :stage
  load_and_authorize_resource :event, :through => :stage

  # GET /events
  # GET /events.json
  def index
    @current_stage = params[:stage].nil? ? current_user.stages.first : Stage.find_by_id(params[:stage])
    
    @stages = current_user.stages
    @events = @current_stage.events

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /event/new
  def new

  end

end