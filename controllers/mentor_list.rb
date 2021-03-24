require 'sinatra'
require_relative '../helpers/authenticated'

get '/mentors' do
  authenticated
  unsorted_mentors = User.retrieve_users(0)
  session[:interest_areas] = "field1,field2,field3"
  # Calculate levenshtein distance for each mentor and store in an array
  values = unsorted_mentors.map { |mentor| User.levenshtein_distance(mentor[:interest_areas], session[:interest_areas]) }
  # Combines mentors and levenshtein distance values into a hash that is sorted and returned
  @mentors = Hash[unsorted_mentors.zip(values).sort_by {|k, v| v}].keys
  erb :mentorList
end
