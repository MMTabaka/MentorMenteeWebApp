require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

post '/accept-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  mentor = User.where(id: connection[:id][:mentor_id])
  
  #connection.update(status: 1)
  redirect '/accept-mentee'
end

get '/accept-mentee' do
  user = User[session[:user]]
  connection = Connection.where(mentee_id: user[:id], active: 1)
  mentor = User.where(id: connection[:id][:mentor_id])
  
  @status = "You have accepted #{mentor[:id][:name]} as your mentor. Wait for their decision."
  erb :request_mentor
end