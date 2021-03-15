require "sinatra"

def authenticated
  redirect "/login" unless session[:user].nil?
end