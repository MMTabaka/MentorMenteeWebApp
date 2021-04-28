require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'
require_relative '../helpers/get_users.rb'
require_relative '../helpers/rejection.rb'

get '/' do
  authenticated
  user = User[session[:user]]
  user_redirect(user)
end

get '/login' do
  @loggedIn = false
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


get '/profile' do
  user = User[session[:user]]
  @username = user[:name]
  @email = user[:email]
  @department = user[:department]
  @area = user[:interest_areas]
  @bio = user[:bio]
  erb :profile
end


get '/logout' do
  session.clear
  redirect '/login'
end
