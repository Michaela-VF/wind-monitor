require "net/http"
require "json"

TURBINES = [ 1, 2, 3, 4, 5 ]

loop do
  TURBINES.each do |id|
    data = {
      reading: {
        turbine_id: id,
        wind_speed: rand(4.0..15.0).round(2),
        power_output: rand(0.2..2.5).round(2)
      }
    }

    uri = URI("http://localhost:3000/readings")

    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    req.body = data.to_json

    http.request(req)

    puts "Sent reading for turbine #{id}"
  end

  sleep 5
end
