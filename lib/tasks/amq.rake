namespace :onering_amq do
  desc 'Listens for messages from activemq'
  task :listen => :environment do
    puts "XXX"
    Log.log "\n\nDone.\n"
  end
end