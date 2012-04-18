scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  Rails.logger.info 'Starting cron job to read from glu...'
  require 'glu_plugin'
  reader = GluPlugin::Reader.new
  reader.update
  Rails.logger.info '...Finished cron job to read from glu'
end