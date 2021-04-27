require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

post '/connected' do
  user = User[session[:user]]
  if user[:user_type] == UserType::MENTOR
    connection = Connection.where(mentor_id: user[:id], active: 1)
    mentee = User.where(id: connection[:id][:mentee_id])
  elsif user[:user_type] == UserType::MENTEE
    connection = Connection.where(mentee_id: user[:id], active: 1)
    mentor = User.where(id: connection[:id][:mentor_id])
  end
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