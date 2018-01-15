#!/usr/bin/ruby

require 'mqtt'

msg = "A" * 1024

MQTT::Client.connect(:host=>'mqtt-pi.local', :keep_alive=>88600) do |c|
  loop do
    st = Time.new
    count = 0
    100.times do
      (0..100).each do |i|
        c.publish(sprintf("test/%02d", i), msg)
        count += 1
      end
    end
    et = Time.new
    diff = (et - st).to_f
    t = diff / count
    mps = 1.0 / t
    puts "send : message_per_second=#{mps}"
  end
end
