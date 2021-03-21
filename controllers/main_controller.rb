require 'sinatra'

get '/' do
  @departments = Department.all
  @interests = Interest.all
  erb :addInfo
end
