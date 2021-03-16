require 'sinatra'
require_relative '../helpers/authenticated'

get "/" do
  authenticated
  redirect "/temp-user-page"
end

get "/login" do
  redirect "/temp-user-page" if session[:user]
  session[:is_valid] = true if session[:is_valid].nil?
  @is_valid = session[:is_valid]
  erb :login
end

post "/login" do
  @email = params["email"]
  @password = params["pass"]
  
  user = M_user.login(@email, @password)
  
  unless user.nil?
    session[:user] = user
    session[:is_valid] = nil
    redirect "/temp-user-page"
  else
    session[:is_valid] = false
  end
  redirect "/login"
end

get "/temp-user-page" do
  redirect "/login" unless session[:user]
  "You are logged in! #{session[:user][:email]}"
end

get "/logout" do
  redirect "/login" unless session[:user]
  session.clear
  "You have been logged out successfully"
end