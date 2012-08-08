#encoding: utf-8

class JqmController < ApplicationController
  layout "jqm"
  
  before_filter :find_provider
  
  def index
    if @provider.theater?
      @stages = @provider.user.stages
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
      flash[:notice] = "Neznáme javisko :("
      render :not_found
    else
      @dates = EventDate.where("date>:now AND stage_id=:stage_id", {
        :now => Time.now.strftime("%Y%m%d"),
        :stage_id => @stage.id
      }).group(:date)
    end
  end
  
  def day
    provider_stages = @provider.user.stages
    @event_dates = EventDate.where('stage_id IN (?) AND date=?', provider_stages, params[:date]).group(:datetime).order(:datetime)
    if @event_dates.empty?
      flash[:notice] = "Nič na programe :("
      render :not_found
    else
      @today = @event_dates.first.datetime
    end
  end

  def detail
    @event = Event.find_by_id(params[:id])
    if @event
      render :detail
    else
      flash[:notice] = "Predstavenie sa nenašlo :("
      render :not_found
    end
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