require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_redirect.rb'
require_relative '../helpers/get_users.rb'
require_relative '../helpers/rejection.rb'
require_relative '../helpers/redirect_home.rb'

get '/' do
  authenticated
  user = User[session[:user]]
  user_redirect(user)
end

get '/login' do
  redirect '/' if session[:user]
  session[:is_valid] = true if session[:is_valid].nil?
  # Delete and return validity status
  @is_valid = session.delete(:is_valid)
  @logged_in = false
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

get '/logout' do
  session.clear
  redirect '/login'
end

# Hides error pages
=begin
disable :raise_errors
disable :show_exceptions

not_found do
  "Page was not found"
end


error do
  "Sorry, we couldn't find that page. Try https://percent-engine-4567.codio.io/"
end
=end