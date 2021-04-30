require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/redirect_home.rb'

def authenticated
  redirect '/login' if session[:user].nil?
  @logged_in = true
end

# Handles redirection to login if admin user is not logged in yet
# @return [User] admin user if logged in
def authenticated_as_admin
  user_id = session[:user]
  return redirect '/admin/login' if user_id.nil?

  user = User[user_id]
  redirect '/admin/login' unless user[:user_type] == UserType::ADMIN
  user
end

# Return true if currently logged in as admin, otherwise returns false
def authenticated_as_admin?
  user_id = session[:user]
  return false if user_id.nil?

  user = User[user_id]
  user[:user_type] == UserType::ADMIN
end
