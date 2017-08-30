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
	@uptime = 100
  erb :sim
end

get '/checkstatus/:ipaddress' do
	content_type :json

  website = params[:ipaddress]
	current_uptime = params[:uptime].to_i
	uptime = current_uptime

	status = "500"
	begin
		status = HTTP.timeout(:read => 2).get("http://" + website + "/health").status.to_s
	rescue HTTP::ConnectionError, Errno::ECONNRESET
	end

	staaa = "500"
	begin
		staaa = HTTP.timeout(:read => 2).get("http://" + website + "/cats").status.to_s
	rescue HTTP::ConnectionError, Errno::ECONNRESET
	end

	@uptime = current_uptime - 1 unless staaa == "200 OK"
	@uptime = current_uptime if staaa == "200 OK"

  up = status == "200 OK"
  { :up => up, :cache => params["ipaddress"], :status => status, :uptime => @uptime }.to_json
end
