scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  worklog = Worklog.create!(name: "Glu cron", start: Time.now)
  Rails.logger.info "Starting cron job to read from glu #{worklog}..."
  require 'glu_plugin'
  reader = GluPlugin::Reader.new
  reader.update
  worklog.end = Time.now
  worklog.save!
  Rails.logger.info "...Finished cron job to read from glu #{worklog}"
end

scheduler.every("2h") do
  worklog = Worklog.create!(name: "Chef cron", start: Time.now)
  Rails.logger.info "Starting cron job to read from chef #{worklog}..."
  require 'chef_plugin'
  reader = ChefPlugin::Reader.new
  reader.update
  worklog.end = Time.now
  worklog.save!
  Rails.logger.info "...Finished cron job to read from chef #{worklog}"
end