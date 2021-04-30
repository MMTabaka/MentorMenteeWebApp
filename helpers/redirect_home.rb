require 'sinatra'

def redirect_home(status)
  redirect '/' if get_users[2][:id][:status] != status
end