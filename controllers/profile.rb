get '/profile/:id/?' do |id|
  puts id
  @user = User[id]
  halt 404 if @user.nil?
  erb :mentorListDetail
end
