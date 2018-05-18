module Cron::Helper
  TIME_FORMAT = "%Y-%m-%dT%H:%M.%LZ"

  def current_time
    Time.now.to_s TIME_FORMAT
  end
end
