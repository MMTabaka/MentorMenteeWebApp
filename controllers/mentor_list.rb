require 'sinatra'
require_relative '../helpers/authenticated'

get '/mentors' do
  authenticated
  user = User[session[:user]]
  puts user[:interest_areas]
  redirect '/request-history' if user[:user_type] == UserType::MENTOR
  unsorted_mentors = User.retrieve_users(UserType::MENTOR)
  # Combines mentors and macth factor values into a hash that is sorted and returned
  @mentors = Hash[unsorted_mentors.zip(unsorted_mentors.map { |mentor| user.match_factor(mentor) }).sort_by {|k, v| v}].keys.reverse()
  erb :mentorList
end