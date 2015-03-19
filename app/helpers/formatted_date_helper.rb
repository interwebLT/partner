module FormattedDateHelper
  def formatted_date date_string
    date_string.to_date.strftime('%Y-%m-%d') unless date_string.nil?
  end

  def formatted_timestamp timestamp
    timestamp.in_time_zone.strftime('%F %T %Z') unless timestamp.nil?
  end
end
