#encoding: utf-8

class JqmController < ApplicationController
  layout "jqm"
  
  before_filter :find_provider
  
  def index
    @stages = @provider.user.stages
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