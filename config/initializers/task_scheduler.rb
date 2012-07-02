scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  require 'glu_plugin'
  GluPlugin::run_update('cron')
end

scheduler.every("2h") do
  worklog = Worklog.create!(name: "Chef cron", start: Time.now)
  Rails.logger.info "Starting cron job to read from chef #{worklog}..."
  begin
    require 'chef_plugin'
    reader = ChefPlugin::Reader.new(worklog)
    reader.update
  rescue => e
    worklog.error = e.to_s
  end
  worklog.end = Time.now
  worklog.save!
  Rails.logger.info "...Finished cron job to read from chef #{worklog}"
end