require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

post '/connected' do
  connection = get_users[2]
  connection.update(status: 3)
  redirect '/connected'
end

get '/connected' do
  user = get_users[3]
  @email = user[:id][:email]
  @username = user[:id][:name]
  @email = user[:id][:email]
  @department = user[:id][:department]
  @area = user[:id][:interest_areas]
  @bio = user[:id][:bio]
  authenticated
  erb :myMate
end