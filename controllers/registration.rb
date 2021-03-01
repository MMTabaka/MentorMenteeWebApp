require 'sinatra'

get '/' do
  'Hello World!'
end

get '/registration' do
  erb :registration
end

post '/registration' do
  puts params
  # TODO: validation & actual registration
  redirect '/'
end
