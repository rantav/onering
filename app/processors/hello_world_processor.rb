# require 'processors/application'

class HelloWorldProcessor < ApplicationProcessor
  subscribes_to :hello_world

  def on_message(message)
    puts "received: " + message
  end
end