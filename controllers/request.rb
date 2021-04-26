require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

get '/request-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  mentor = User.where(id: connection[:id][:mentor_id])
  
  @username = mentor[:id][:name]
  @status = "User #{@username} has received your request. Check your email inbox for a reply.
  After arranged meeting decide if you want to accept the user as your mentor."
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
    active: 1
  }
  
  Connection.add(connection_details)
  redirect '/request-mentee'
end


get '/request-mentor' do
  user = User[session[:user]]
  connection = Connection.where(mentor_id: user[:id], active: 1)
  mentee = User.where(id: connection[:id][:mentee_id])
  
  @username = mentee[:id][:name]
  @department = mentee[:id][:department]
  @status = "User #{@username} has requested a meeting. Check your email inbox to arrange one."
  erb :request_mentor
end

get '/request-history' do
  @history = 20
  @username = 'empty'
  @department = 'empty'
  @sTime = 'empty'
  @eTime = 'empty'
  @reason = 'empty'
  authenticated
  erb :requestHistory
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