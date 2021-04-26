require 'sinatra'
require_relative '../helpers/authenticated'

get '/mentors' do
  authenticated
  user = User[session[:user]]
  unsorted_mentors = User.retrieve_users(UserType::MENTOR)
  # Calculate levenshtein distance for each mentor and store in an array
  values = unsorted_mentors.map { |mentor| User.levenshtein_distance(mentor[:interest_areas], user[:interest_areas]) }
  # Combines mentors and levenshtein distance values into a hash that is sorted and returned
  @mentors = Hash[unsorted_mentors.zip(values).sort_by {|k, v| v}].keys
  erb :mentorList
end

get '/request-mentee' do
  authenticated
  erb :requestingmentee
end

post '/request-mentee' do
  @mentor_id = params['mentor_id']
  puts @mentor_id
  
  authenticated
  user = User[session[:user]]
  
  connection_details = {
    mentee_id: user[:id],
    mentor_id: @mentor_id,
    status: 0,
    active: 1
  }
  
  Connection.add(connection_details)
  redirect '/request-mentee'
end

get '/request-mentor' do
  user = User[session[:user]]
  connection = Connection.where(mentor_id: user[:id], active: 1)
  mentee = User.where(id: connection[:id][:mentee_id])
  
  @username = mentee[:id][:name]
  @department = mentee[:id][:department]
  @status = "User #{@username} has requested a meeting. Check your email inbox to arrange one."
  erb :request_mentor
end