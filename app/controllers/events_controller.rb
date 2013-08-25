#encoding: utf-8

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

  def create
    @event = @stage.events.new(params[:event])

    if @event.save
      redirect_to stage_event_path(@stage, @event), notice: 'Podujatie bolo úspešne vytvorené.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to stage_event_path(@stage, @event), notice: "Podujatie bolo upravené."
    else
      render action: 'edit'
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    stage = @event.stage
    @event.destroy

    respond_to do |format|
      format.html { redirect_to stage_events_path(stage) }
      format.json { head :no_content }
      format.js { render nothing: true, status: 200 }
    end
  end
end