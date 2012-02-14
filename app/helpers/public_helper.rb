# encoding:utf-8

module PublicHelper

  def weekday(datetime)
    wdays = %w{Nedeľa Pondelok Utorok Streda Štvrtok Piatok Sobota}
    w = datetime.strftime("%w")
    wdays[w.to_i]
  end

end
