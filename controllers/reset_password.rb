
get '/reset-password/?' do
  @reset_complete = false
  erb :resetPassword
end
