require 'sinatra'

get "/login" do
    erb :login
end

post "/login" do
    @email = params["email"]
    @password = params["password"]
    
    if M_user.login(@email, @password)
        redirect "/home"
    end
end