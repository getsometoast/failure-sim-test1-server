require 'sinatra'
require 'http'

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
  website = "www.realestate.com.au" #replace with IP
  status = HTTP.timeout(:read => 2).get("https://" + website + "/buy").status.to_s
  up = status == "200 OK"
  { :num => num, :up => up, :cache => params["ipaddress"], :status => status }.to_json
end
