class PublicController < ApplicationController
  layout "public"

  def index
    now = Time.now.strftime("%Y%m%d")
    #@events = EventDate.where("date>'#{now}'").group(:event_id).map {|ed| ed.event }
    @dates = EventDate.where("date>'#{now}'").group(:date)
  end

  def detail
    @event = Event.find_by_id(params[:id])
    if @event
      render template: 'public/detail', layout: 'jqm_page'
    else
      render template: 'public/event_not_found'
    end

  end
end
