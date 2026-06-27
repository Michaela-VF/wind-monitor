require "net/http"
require "json"

# https://docs.ruby-lang.org/en/master/Net/HTTP.html

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

    # TODO: maybe wrap with HTTParty

    # creates a destination address
    uri = URI("http://localhost:3000/readings")

    # creates a connection object
    http = Net::HTTP.new(uri.host, uri.port)

    # creates a `post` request object
    req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    req.body = data.to_json

    # sends the request
    http.request(req)

    puts "Sent reading for turbine #{id}"
  end

  sleep 5
end
