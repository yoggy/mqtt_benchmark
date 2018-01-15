#!/usr/bin/ruby

require 'mqtt'

h = {}

MQTT::Client.connect(:host=>'mqtt-pi.local', :keep_alive=>88600) do |c|
  st = Time.new
  count = 0
  c.get('#') do |topic, message|
    if h.key?(topic)
      h[topic] += 1
    else
      h[topic] = 1
    end

    count += 1
    if count == 1000
      diff = (Time.now - st).to_f
      t = diff / count
      mps = 1.0 / t
      puts "recv : message_per_secound=#{mps}"
      h.each do |k, v|
        print "#{v}, "
      end
      
      count = 0
      st = Time.now
    end
  end
end
