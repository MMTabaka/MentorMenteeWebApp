require 'sinatra'
require_relative '../helpers/authenticated'

get '/mentors' do
  # authenticated
  @mentors = User.retrieve_users(0)
  erb :mentorList
end
