require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/redirect_home.rb'


get '/connected' do
  authenticated
  redirect_home(3)
  @user = get_users[3]
  erb :myMate
end

post '/connected' do
  connection = get_users[2]
  connection.update(status: 3)
  redirect '/connected'
end