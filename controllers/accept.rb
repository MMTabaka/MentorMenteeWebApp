require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'
require_relative '../helpers/get_users.rb'
require_relative '../helpers/rejection.rb'

post '/accept-mentee' do
  connection = get_users[2]
  connection.update(status: 1)
  redirect '/accept-mentee'
end

get '/accept-mentee' do
  mentor = get_users[0]
  @status = "You have accepted #{mentor[:id][:name]} as your mentor. Wait for their decision."
  erb :request_mentor
end

get '/accept-mentor' do
  mentee = get_users[1]
  @username = mentee[:id][:name]
  @user_type == "Mentor"
  @bio = 'sth'
  @status = "User #{@username} has accepted you as their mentor. "
  authenticated
  erb :requestingmentee
end

post '/reject-mentor' do
  rejection
end
  
post '/reject-mentee' do
  rejection
end