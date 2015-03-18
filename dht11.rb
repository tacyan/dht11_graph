#cding: utf-8
require 'sinatra'
require 'json'

set :environment, :production
set :port, 1234


  get '/' do


    erb :index
  end

  post '/temperature/*/humidity/*' do
    array = params[:splat]
    "{temperature: #{array[0]} humidity: #{array[1]}}"
  end
