require 'sinatra'
require_relative '../helpers/authenticated'
require_relative '../helpers/redirect_home.rb'

get '/mentors' do
  authenticated
  user = User[session[:user]]
  redirect '/' if user[:user_type] == UserType::MENTOR
  redirect '/' if Connection.exist?(user[:user_type], user[:id])
  unsorted_mentors = User.retrieve_users(UserType::MENTOR)
  # Calculate levenshtein distance for each mentor and store in an array
  values = unsorted_mentors.map { |mentor| User.levenshtein_distance(mentor[:interest_areas], user[:interest_areas]) }
  # Combines mentors and levenshtein distance values into a hash that is sorted and returned
  @mentors = Hash[unsorted_mentors.zip(values).sort_by {|k, v| v}].keys
  erb :mentorList
end

