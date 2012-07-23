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
      Log.log "Stomp started."
      @client.subscribe("/topic/#{@amq_topic}") do |msg|
        puts msg
      end
      @client.join
      Log.log "Stomp stopped."
    end
  end
end