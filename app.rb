# app.rb

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'vonage'
require 'dotenv/load'

get '/' do
  redirect '/sms'
end

get '/sms' do
  erb :sms
end

post '/sms' do
  to_number = params[:number]
  message = params[:message]
  client = Vonage::Client.new(api_key: ENV['VONAGE_API_KEY'], api_secret: ENV['VONAGE_API_SECRET'])

  begin
    response = client.sms.send(from: 'Vonage', to: to_number, text: message)
    @status_message = { class: "flash-success", text: "Message sent successfully." }
  rescue Vonage::ServiceError => e
    @status_message = { class: "flash-error", text: "Message failed with error: #{e.response[:messages][0][:error_text]}"}
  end

  erb :sms
end
