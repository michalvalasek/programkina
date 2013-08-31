#encoding: utf-8

class JqmController < ApplicationController
  layout "jqm"
  
  before_filter :find_provider
  
  def index
    @stages = @provider.user.stages
    @sections = @provider.user.sections.order(:name)
    if @provider.theater?
      render :index_theater
    elsif @provider.festival?
      @days = @provider.festival_days
      render :index_festival
    end
  end
  
  def stage
    @stage = Stage.find_by_id(params[:id])
    
    #@events = EventDate.where("date>'#{now}'").group(:event_id).map {|ed| ed.event }
    
    if @stage.nil? || @stage.user != @provider.user
      flash[:notice] = "Neznáma sála :("
      render :not_found
    else
      @dates = EventDate.where("datetime>:now AND stage_id=:stage_id", {
        :now => Time.now,
        :stage_id => @stage.id
      }).group(:date)
    end
  end

  def section
    @section = Section.find_by_id(params[:id])
    
    if @section.nil? || @section.user != @provider.user
      flash[:notice] = "Neznáma sekcia :("
      render :not_found
    else
      @dates = EventDate.where("datetime>:now AND event_id IN (:events)", {
        :now => Time.now,
        :events => @section.events
      }).group(:date)
    end
  end
  
  def day
    @provider_stages = @provider.user.stages
    
    stages = @provider_stages.clone
    unless params[:stage].blank?
      @selected_stage_id = params[:stage].to_i
      stages.select!{ |s| s.id == @selected_stage_id }
    end
    
    @event_dates = EventDate.where('stage_id IN (?) AND date=?', stages, params[:date]).group(:datetime).order(:datetime)
    if @event_dates.empty?
      flash[:notice] = "Nič na programe :("
      render :not_found
    end
  end

  def detail
    @event = Event.find_by_id(params[:id])
    if @event
      @show_back_button = true
      render :detail
    else
      flash[:notice] = "Predstavenie sa nenašlo :("
      render :not_found
    end
  end
  
  def search
    @query = params[:search]
    redirect_to jqm_root_path if @query.blank?
    @events = Event.where("title LIKE '%#{@query}%' OR orig_title LIKE '%#{@query}%'")
  end
  
  private
  
    def find_provider
      @provider = Account.find_by_subdomain(request.subdomain)
      if @provider.nil?
        flash[:notice] = "Na subdoméne '#{request.subdomain}.programkina.sk' nič nie je :( <br /> Žeby preklep?".html_safe
        render :not_found
      end
    end
end