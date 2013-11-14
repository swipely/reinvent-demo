class Conf < OpenStruct
  def period
    '24 hours'
  end

  def start_date_time
    Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S")
  end

  def get_binding
    binding
  end
end
