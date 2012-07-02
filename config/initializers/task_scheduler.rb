scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  require 'glu_plugin'
  GluPlugin::run_update('cron')
end

scheduler.every("2h") do
  require 'glu_plugin'
  ChefPlugin::run_update('cron')
end