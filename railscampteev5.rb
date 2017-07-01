require 'sinatra'
require 'net/http'
require 'uri'

# raise "No WUFOO_API_KEY found in ENV" unless ENV["WUFOO_API_KEY"]

get '/' do
  haml :v5
end

post '/order' do
  # Net::HTTP.post_form URI.parse("http://toolmantim.wufoo.com/api/insert/"),
  #                     {
  #                       "w_api_key" => ENV["WUFOO_API_KEY"],
  #                       "w_form" => "railscamp-tee-v5",
  #                       "4" => params[:name],
  #                       "3" => params[:sex],
  #                       "5" => params[:size]
  #                     }
  "All good!"
end
