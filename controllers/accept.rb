require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'
require_relative '../helpers/get_users.rb'
require_relative '../helpers/rejection.rb'
require_relative '../helpers/redirect_home.rb'


get '/accept-mentee' do
  authenticated
  redirect_home(1)
  mentor = get_users[0]
  @status = "You have accepted #{mentor[:id][:name]} as your mentor. Wait for their decision."
  erb :request_mentor
end

post '/accept-mentee' do
  connection = get_users[2]
  connection.update(status: 1, request_time: Time.now.gmtime.to_s)
  redirect '/accept-mentee'
end


get '/accept-mentor' do
  authenticated
  redirect_home(1)
  mentee = get_users[1]
  @username = mentee[:id][:name]
  @department = mentee[:id][:department]
  @user_type == "Mentor"
  @status = "User #{@username} has accepted you as their mentor. "
  @time = get_users[2][:id][:request_time]
  erb :requestingmentee
end

post '/reject-mentor' do
  rejection
end
  
post '/reject-mentee' do
  rejection
end