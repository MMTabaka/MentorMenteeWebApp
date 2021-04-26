require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'

get '/' do
  authenticated
  user = User[session[:user]]
  user_redirect(user)
end

get '/login' do
  redirect '/' if session[:user]
  session[:is_valid] = true if session[:is_valid].nil?
  @is_valid = session[:is_valid]
  erb :login
end

post '/login' do
  @email = params['email']
  @password = params['pass']
  user = User.login(@email, @password)
  if user.nil?
    session[:is_valid] = false
  else
    # Setting user id to access logged in user later
    session[:user] = user.id
    session[:is_valid] = nil
    redirect '/'
  end
  redirect '/login'
end

get '/temp-user-page' do
  authenticated
  "You are logged in! Id: #{session[:user]}"
end

get '/request-history' do
  @history = 4
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

get '/profile' do
  @username = 'empty'
   
  erb :profile
end

# TODO: This should be POST
get '/logout' do
  session.clear
  redirect '/login'
end
