require 'sinatra'
require_relative '../helpers/authenticated'

get '/profile' do
  authenticated
  user = User[session[:user]]
  @username = user.name
  @validation = { 'valid' => true, 'errors' => {} }
  erb :profile
end

post '/profile' do
  authenticated
  user = User[session[:user]]
  user_hash = user.to_hash
  
  params.each do |k,v|
    if v != "" then
      user_hash[k.to_sym] = v if user_hash.key?(k.to_sym)
    end
  end
  @username = user.name
  @validation = { 'valid' => true, 'errors' => {} }
  user_hash.delete(user_hash.keys.first)
  puts user_hash
  user.update(user_hash)
  erb :profile
end
