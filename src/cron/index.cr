require "schedule"
require "./tasks/*"
require "./helpers/*"

module Cron
  extend self

  def run
    # Schedule.every(15.seconds) do
    #  Tasks::Users.cron_runner
    # end
    Tasks::Users.cron_runner unless TEST
    Tasks::LibraryEntries.cron_runner unless TEST
  end
end

# Schedule.every(:sunday, "00:00:00") do
#  puts "House Keeping!"
# end

Schedule.exception_handler do |ex|
  puts "Exception recued! #{ex.message}"
end
