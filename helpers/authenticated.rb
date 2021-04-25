require 'sinatra'

def authenticated
  redirect '/login' if session[:user].nil?
end
