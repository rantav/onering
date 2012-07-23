module Realtime
  def self.listen
    client = Stomp::Client.new("test", "user", "localhost", 61613)
    Log.log "\nStomp started.\n"
    client.subscribe("/topic/onering") do |msg|
      puts msg
    end
    client.join
  end
end