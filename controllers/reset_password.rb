require 'sinatra'

get '/reset-password/?' do
  # Set variable to session value if it exists, simultaneously deleting it as well.
  @reset_complete = session.delete(:reset_complete) || true
  erb :resetPassword
end

post '/reset-password/?' do
  user = User.where(email: params[:email]).single_record
  user&.reset_password
  session[:reset_complete] = true
  redirect '/reset-password'
end
