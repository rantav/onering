require 'glu_plugin'
require 'chef_plugin'

module Realtime
  def self.listen
    listener = Listner.new
    listener.configure
    listener.listen
  end

  class Listner
    def configure
      @settings = Setting.get
      @amq_connection_string = @settings.amq_connection_string
      @amq_topic = @settings.amq_topic
      @client = Stomp::Client.new(@amq_connection_string)
    end
    def listen
      @handler = MessageHandler.new
      Rails.logger.info ">>> Stomp started."
      @client.subscribe("/topic/#{@amq_topic}") do |msg|
        Rails.logger.info "stomp acepted: #{msg}"
        @handler.handle(msg.body)
      end
      @client.join
      Rails.logger.info ">>> Stomp stopped."
    end
  end

  class MessageHandler

    # The message should look like this:
    # {"source": "chef", "host": "api19.nydc1.outbrain.com"}
    # {"source": "glu", "host": "api19.nydc1.outbrain.com"}
    def handle(msg)
      json = JSON.parse(msg)
      source = json['source'] # glu or chef
      host = json['host'] # host name
      if source == 'glu'
        handle_glu(host)
      elsif source == 'chef'
        handle_chef(host)
      end
    end

    def handle_chef(host)
      runner = ChefPlugin::Runner.new
      runner.run_update('amq')
      return runner
    end

    def handle_glu(host)
      runner = GluPlugin::Runner.new
      runner.run_update('amq')
      return runner
    end

  end
end