# send from curl:
# curl -D - -X POST -H "Content-Type: text/xml" -d '{"curl": "yes!"}' "http://localhost:8161/admin/send/my_topic?type=topic&JMSDeliveryMode=nonpersistent"
require 'realtime'
namespace :onering_amq do
  desc 'Listens for messages from activemq'
  task :listen => :environment do
    Realtime::listen
    Log.log "\n\nDone ???.\n"
  end
end