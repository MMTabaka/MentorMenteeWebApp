require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

post '/connected' do
  connection = get_users[2]
  connection.update(status: 3)
  redirect '/connected'
end

get '/connected' do
  @email = 'empty'
  @username = 'empty'
  @email = 'empty'
  @department = 'empty'
  @area = 'empty'
  @bio = 'empty'
  authenticated
  erb :myMate
end