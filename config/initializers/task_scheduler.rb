scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  require 'glu_plugin'
  GluPlugin::Runner.new.run_update('cron')
end

scheduler.every("2h") do
  require 'chef_plugin'
  ChefPlugin::Runner.new.run_update('cron')
end