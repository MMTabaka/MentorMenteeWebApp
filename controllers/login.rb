require 'sinatra'

get "/" do
    redirect "/login" unless session[:logged_in]
    erb :index
end

get "/login" do
    erb :login
end

post "/login" do
    @email = params["email"]
    @password = params["password"]
    
    if M_user.login(@email, @password)
        session[:logged_in] = true
        redirect "/"
    end
end

get "/logout" do
  session.clear
  erb :logout
end