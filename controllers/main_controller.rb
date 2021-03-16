require 'sinatra'

get '/' do
  puts session[:user]
end
