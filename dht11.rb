#cding: utf-8
require 'sinatra'

set :environment, :production
set :port, 1234


  get '/' do


    erb :index
  end
