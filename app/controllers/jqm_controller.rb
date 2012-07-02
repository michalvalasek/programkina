#encoding: utf-8

class JqmController < ApplicationController
  layout "jqm"
  
  before_filter :find_provider
  
  def index
    now = Time.now.strftime("%Y%m%d")
    #@events = EventDate.where("date>'#{now}'").group(:event_id).map {|ed| ed.event }
    @dates = EventDate.where("date>'#{now}'").group(:date)
  end

  def detail
    @event = Event.find_by_id(params[:id])
    if @event
      render 'detail', layout: 'jqm_page'
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