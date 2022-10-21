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
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

ENV.each { |k, v| env(k, v) }

every 1.month, at: 'start of the month at 1am' do
  rake 'batch:get_user_birth_coffee_reward', environment: 'development'
end

every 1.day, at: '1:00 am' do
  rake 'batch:expire_point', environment: 'development'
end
