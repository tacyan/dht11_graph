#cding: utf-8
require 'sinatra'
require 'json'
require 'redis'

set :environment, :production
set :port, 1234


  get '/' do

    #redis = Redis.new host:"127.0.0.1", port:"6379"
    #@temperature = redis.get("temperature") 
    erb :index
  end

  get '/test/:temperature' do
    redis = Redis.new host:"127.0.0.1", port:"6379"
    count = redis.llen "temperature" 
    redis.del "temperature" if count > 50 
    redis.rpush "temperature", "#{params[:temperature]}"
    
  end

  get '/rial' do
    

    erb :dynamic
  end

  get '/num' do

    "60"
  end


  get '/temperature' do
    redis = Redis.new host:"127.0.0.1", port:"6379"
    temp = redis.lrange "temperature", 0, 50
    temp.join(", ")
  end

  post '/', provides: :json do
    @temp = JSON.parse request.body.read
    @temperature = @temp.values
    
  end

  post '/temperature/*/humidity/*' do
    array = params[:splat]
    "{temperature: #{array[0]} humidity: #{array[1]}}"
  end
