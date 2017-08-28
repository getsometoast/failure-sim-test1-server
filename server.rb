require 'sinatra'

get '/health' do
  return 'OK'
end

get "/hello/:name" do
  @greeting_name = params[:name]
  "Hello, #{@greeting_name.capitalize}!"
end

get "/" do
  erb :test
end

post "/" do
  redirect "/simulator/" + params["ip-input"]
end

get "/simulator/:ipaddress" do 
  @ipaddress = params["ipaddress"]
  erb :sim
end

get '/checkstatus/:ipaddress' do
  content_type :json
  num = rand(6) + 1
  # do http request here to the ipaddress/health...
  { :num => num, :up => true, :cache => params["ipaddress"] }.to_json
end
