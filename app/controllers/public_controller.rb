class PublicController < ApplicationController
  layout "public"
  
  def index
    @providers = Account.all
  end
  
  def contact
  end

  # returns JSON with closest two events for given provider
  def pebble
    provider = Account.find(params[:provider_id])

    dates = EventDate.where("datetime>:now AND stage_id IN (:stage_id)", {
        :now => (Time.now + 2.hours),
        :stage_id => provider.user.stages.map(&:id)
      }).order(:datetime).limit(2)
    
    output = {}
    dates.each do |date| 
      output[output.count] = ActiveSupport::Inflector.transliterate(date.event.title.slice(0,20))
      output[output.count] = date.datetime.strftime("%H:%M") + " " + ActiveSupport::Inflector.transliterate(date.event.stage.name.gsub(/[a-z]|\s/,''))
    end
    
    render json: output
  
  rescue ActiveRecord::RecordNotFound
    render json: {}
  end
end
