module AdminHelper
  def format_date(date)
    date.strftime('%B %-d, %Y')
  end

  def format_time(time)
    time.strftime('%H:%M')
  end
end
