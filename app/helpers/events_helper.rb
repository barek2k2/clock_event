module EventsHelper
  def format_time(time)
    time.strftime("%I:%M:%S %p, %A %B, %Y (%Z)")
  end

  def format_event_type(event_type)
    event_type.to_s.humanize
  end
end
