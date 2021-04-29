require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'
require_relative '../helpers/get_users.rb'
require_relative '../helpers/rejection.rb'

get '/request-mentee' do
  mentor = get_users[0]
  @username = mentor[:id][:name]
  @user_type = "Mentee"
  @status = "User #{@username} has received your request. Check your email inbox for a reply.
  After arranged meeting decide if you want to accept the user as your mentor."
  @time = get_users[2][:id][:request_time]
  authenticated
  erb :requestingmentee
end

post '/request-mentee' do
  @mentor_id = params['mentor_id']
  puts @mentor_id
  
  authenticated
  user = User[session[:user]]
  
  connection_details = {
    mentee_id: user[:id],
    mentor_id: @mentor_id,
    status: 0,
    active: 1,
    request_time: Time.now.gmtime.to_s
  }
  
  Connection.add(connection_details)
  redirect '/request-mentee'
end


get '/request-mentor' do
  mentee = get_users[1]
  
  @username = mentee[:id][:name]
  @department = mentee[:id][:department]
  @status = "User #{@username} has requested a meeting. Check your email inbox to arrange one."
  erb :request_mentor
end

get '/request-history' do
  @user = User[session[:user]]
  @history = Connection.retrieve(@user)
  @department = 'empty'
  @sTime = 'empty'
  @eTime = 'empty'
  @reason = 'empty'
  authenticated
  erb :requestHistory
end

