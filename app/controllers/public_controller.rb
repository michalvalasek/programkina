class PublicController < ApplicationController
  layout "public"
  
  def index
    @providers = Account.all
  end
  
  def contact
  end

  def pebble
    provider = Account.find(params[:provider_id])

    dates = EventDate.where("datetime>:now AND stage_id IN (:stage_id)", {
        :now => Time.now,
        :stage_id => provider.user.stages.map(&:id)
      }).group(:date).limit(1)
    
    data = dates.empty? ? {} : {
      0 => dates.first.datetime.strftime("%H:%M"),
      1 => ActiveSupport::Inflector.transliterate(dates.first.event.title),
      2 => ActiveSupport::Inflector.transliterate(dates.first.event.stage.name)
    }
    
    render json: data
  
  rescue ActiveRecord::RecordNotFound
    render json: {}
  end
end
