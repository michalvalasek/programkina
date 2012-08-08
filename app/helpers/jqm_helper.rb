module JqmHelper
  
  def event_times(event, date)
    times = event.event_dates.where(:date => date).collect do |ed|
      ed.datetime.strftime('%H:%M')
    end
    times.join(', ')
  end
end