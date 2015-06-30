# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
every 1.day do
	Event.where('extract(day   from begins) = ? and extract(month   from begins) = ? and extract(year   from begins) = ?' , Time.now.day,Time.now.month,Time.now.year).each do |e|
		UserMailer.remind_event(e).deliver
	end
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
