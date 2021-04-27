require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

post '/accept-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  mentor = User.where(id: connection[:id][:mentor_id])
  
  connection.update(status: 1)
  redirect '/accept-mentee'
end

get '/accept-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  mentor = User.where(id: connection[:id][:mentor_id])
  
  @status = "You have accepted #{mentor[:id][:name]} as your mentor. Wait for their decision."
  erb :request_mentor
end

get '/accept-mentor' do
  user = User[session[:user]]
  connection = Connection.where(mentor_id: user[:id], active: 1)
  mentee = User.where(id: connection[:id][:mentee_id])
  
  @username = mentee[:id][:name]
  @user_type == "Mentor"
  @bio = 'sth'
  @status = "User #{@username} has accepted you as their mentor. "
  authenticated
  erb :requestingmentee
end

post "/reject-mentor" do
  user = User[session[:user]]
  connection = Connection.where(mentor_id: user[:id], active: 1)
  connection.update(status: 2, active: 0)
  redirect "/"
end
  
post '/reject-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  connection.update(status: 2, active: 0)
  redirect '/'
end