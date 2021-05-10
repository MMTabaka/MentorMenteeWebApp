require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/user_type'
require_relative '../helpers/redirect_home'

get '/admin/?' do
  authenticated_as_admin
  @admin_name = 'Admin John'
  @users = User.all
  erb :admin
end

get '/admin/login/?' do
  redirect '/admin' if authenticated_as_admin?
  # TODO: Refactor this to DRY
  session[:is_valid] = true if session[:is_valid].nil?
  @is_valid = session[:is_valid]
  @logged_in = false
  erb :login
end

post '/admin/login/?' do
  @email = params['email']
  @password = params['pass']
  user = User.login(@email, @password, admin: true)
  if user.nil? || user.user_type != UserType::ADMIN
    session[:is_valid] = false
  else
    # Setting user id to access logged in user later
    session[:user] = user.id
    session[:is_valid] = nil
    redirect '/admin'
  end
  redirect '/admin/login'
end

post '/admin/suspend/?' do
  authenticated_as_admin
  user = User[params['id']]
  user.toggle_suspension
end

post '/admin/reset/?' do
  authenticated_as_admin
  user = User[params['id']]
  user.reset_password
end
