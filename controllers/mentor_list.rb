require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/redirect_home.rb'

get '/mentors' do
  authenticated
  user = User[session[:user]]
  redirect '/' if user[:user_type] == UserType::MENTOR
  redirect '/' if Connection.exist?(user[:user_type], user[:id])
  puts user[:interest_areas]
  redirect '/request-history' if user[:user_type] == UserType::MENTOR
  unsorted_mentors = User.retrieve_users(UserType::MENTOR)
  # Combines mentors and macth factor values into a hash that is sorted and returned
  @mentors = Hash[unsorted_mentors.zip(unsorted_mentors.map { |mentor| user.match_factor(mentor) }).sort_by {|k, v| v}].keys.reverse()
  erb :mentorList
end