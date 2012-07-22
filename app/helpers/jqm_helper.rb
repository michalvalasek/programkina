# encoding:utf-8

module JqmHelper
  
  def weekday(datetime)
    wdays = %w{Nedeľa Pondelok Utorok Streda Štvrtok Piatok Sobota}
    w = datetime.strftime("%w")
    wdays[w.to_i]
  end
  
  def event_times(event, date)
    times = event.event_dates.where(:date => date).collect do |ed|
      ed.datetime.strftime('%H:%M')
    end
    times.join(', ')
  end
end