# app.rb

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'vonage'
require 'dotenv/load'

VONAGE_API_KEY = ENV['VONAGE_API_KEY']
VONAGE_API_SECRET = ENV['VONAGE_API_SECRET']

get '/' do
  redirect '/sms'
end

get '/sms' do
  erb :sms
end

post '/sms' do
  to_number = params[:number]
  message = params[:message]
  client = Vonage::Client.new(api_key: VONAGE_API_KEY, api_secret: VONAGE_API_SECRET)

  client.sms.send(from: 'Vonage', to: to_number, text: message)

  erb :sms
end
