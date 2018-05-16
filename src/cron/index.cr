require "schedule"
require "./tasks/*"
require "./helpers/*"

Schedule.exception_handler do |ex|
  puts "Exception recued! #{ex.message}"
end

module Cron
  extend self

  def run
    Schedule.every(:sunday, "00:00:00") do
      Tasks::Users.cron_runner unless TEST
    Tasks::LibraryEntries.cron_runner unless TEST
    end
  end
end
