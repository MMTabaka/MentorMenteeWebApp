require 'sinatra'
require_relative '../helpers/authenticated'


def authenticated
  redirect '/login' if session[:user].nil?
end

def authenticated_as_admin
  user_id = session[:user]
  return redirect '/admin/login' if user_id.nil?

  user = User[user_id]
  redirect '/admin/login' unless user[:user_type] == UserType::ADMIN
end
