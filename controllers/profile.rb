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
  user_hash = {}
  
  params.each do |k,v|
    if k == "password" && params['password'] != params['re-pass']
      puts "invalid password"
      session[:validation] = { re_pass: 'Passwords do not match' } if @validation == false
      redirect '/profile'
      break
    else
      user_hash[k.to_sym] = v unless v == ''
    end
  end
  @username = user.name
  @validation = { 'valid' => true, 'errors' => {} }
  puts user_hash
  user.update(user_hash)
  erb :profile
end
