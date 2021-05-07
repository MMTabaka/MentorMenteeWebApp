require 'sinatra'

# redirects to home page if user wants to enter any page they are not allowed to
def redirect_home(status)
  redirect '/' if get_users[2][:id][:status] != status
end