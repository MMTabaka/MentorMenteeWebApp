require_relative '../helpers/authenticated'
require_relative '../helpers/user_type'

get %r{/profile/(\d+)/?} do |id|
  authenticated
  # Redirect if it's you profile
  redirect '/account' if session[:user].to_s == id
  puts session[:user]
  @user = User[id]
  # Don't show admins
  halt 404 if @user.nil? || @user[:user_type] == UserType::ADMIN
  erb :mentorListDetail
end
