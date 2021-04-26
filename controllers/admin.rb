require 'sinatra'
require_relative '../helpers/authenticated'

get '/admin/?' do
  # TODO: Implement
  @admin_name = 'Admin John'
  @users = User.all
  erb :admin
end

get '/admin/login/?' do
  # TODO: Implement
  'Admin Login Page'
end

get '/admin/suspend/?' do
  # TODO: change to post
  user = User[1]
  user.toggle_suspension
end
