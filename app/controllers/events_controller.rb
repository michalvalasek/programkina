class EventsController < ApplicationController
  
  before_filter :authenticate_user!

  load_resource :stage
  load_and_authorize_resource :event, :through => :stage

  # GET /events
  # GET /events.json
  def index
    @stages = current_user.stages
  end

  # GET /event/new
  def new

  end

end