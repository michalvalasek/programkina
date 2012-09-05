#encoding: utf-8

module JqmHelper
  
  def event_times(event, date)
    times = event.event_dates.where(:date => date).collect do |ed|
      ed.datetime.strftime('%H:%M')
    end
    times.join(', ')
  end
  
  def fancy_account_type
    case @provider.account_type
    when Account::TYPE_THEATER
      "kino"
    when Account::TYPE_FESTIVAL
      "festival"
    end
  end
end