#encoding: utf-8

class SectionsController < ApplicationController
  
  load_and_authorize_resource

  # GET /sections
  # GET /sections.json
  def index
    @sections = current_user.sections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(params[:section])
    @section.user_id = current_user.id

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Sekcia bola vytvorená.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Sekcia bola upravená.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url, notice: "Sekcia bola vymazaná." }
      format.json { head :no_content }
      format.js { render nothing: true, status: 200 }
    end
  end

  # GET /sections/1/add_events
  def add_events
    @events = Event.where('section_id != ? OR section_id IS NULL', params[:id])
  end

  # POST /sections/1/add_event/1
  def add_event
    @section.events << Event.find_by_id(params[:event_id])

    respond_to do |format|
      format.html { redirect_to sections_url, notice: "Predstavenie bolo pridané do sekcie." }
      format.json { head :no_content }
      format.js { render nothing: true, status: 200 }
    end
  end

  def remove_event
    @section.events.delete(Event.find_by_id(params[:event_id]))
    
    respond_to do |format|
      format.html { redirect_to sections_url, notice: "Predstavenie bolo odstránené zo sekcie." }
      format.json { head :no_content }
      format.js { render nothing: true, status: 200 }
    end
  end

  def remove_all_events
    @section = Section.find(params[:id])
    @section.events.clear    
    respond_to do |format|
      format.html { redirect_to events_section_path(@section), notice: "Všetky predstavenia v tejto sekcii boli vymazané." }
      format.json { head :no_content }
    end
  end

  def events
    @events = @section.events
  end
end
