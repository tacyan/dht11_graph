#!/usr/bin/ruby

require "faraday"
require "json"

time = 1

loop do

  str = `sudo ./data2`
  data = str.split(",")

  temperature = data[1]
  humidity = data[0]

  Faraday.get "http://210.152.137.224:1234/temperature/#{temperature}/humidity/#{humidity}"
  Faraday.get "http://210.152.137.224:1234/test/#{temperature}"

  client = Faraday.new(:url => "http://210.152.137.224:1234/")
  res = client.post do |req|
    req.url '/'
    req.headers['Content-Type'] = 'application/json'
    req.body = { metric: { sensor: "temperature", value: "#{temperature}", monitored_at: Time.now} }.to_json
    req.body = { metric: { sensor: "humidity", value: "#{humidity}", monitored_at: Time.now} }.to_json
  end

sleep time

end
