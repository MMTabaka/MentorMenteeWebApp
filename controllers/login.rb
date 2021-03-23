require 'sinatra'
require_relative '../helpers/authenticated'

get '/' do
  # authenticated
  redirect '/login' unless session[:user]
  unless session[:user].nil?
    user = User[session[:user]]
    return redirect '/mentors' if (user[:user_type]) == 1
    redirect '/temp-user-page'
  end
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
  redirect '/login' unless session[:user]
  "You are logged in! Id: #{session[:user]}"
end

get '/logout' do
  redirect '/login' unless session[:user]
  session.clear
  'You have been logged out successfully'
end