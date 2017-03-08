pinger = ICMPPinger.new

pinger.add_target('127.0.0.1')
pinger.add_target('8.8.8.8')
pinger.add_target('99.99.99.99')

results = pinger.send_pings(1000, 8, 50, [0.95, 0.99])
results.each do |host, res|
  avg_time = res[0] > 0 ? "time #{res[0]}ms" : 'timeout'
  lost = res[1]
  percentiles = res[2].map { |perc, v| ", #{perc} - #{v}ms" }.join
  puts "#{host}\n   #{avg_time}, #{lost}% lost#{percentiles}"
end

# # Sample output
#
# 127.0.0.1
#    time 26.25ms, 0% lost, 0.95 - 62.6ms, 0.99 - 74.92ms
# 8.8.8.8
#    time 35766.875ms, 0% lost, 0.95 - 36591.85ms, 0.99 - 36846.37ms
# 99.99.99.99
#    timeout, 100% lost
