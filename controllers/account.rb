require 'sinatra'
require_relative '../helpers/authenticated'

get '/account' do
  authenticated
  user = User[session[:user]]
  @user = user
  session[:validation] = {} if session[:validation].nil?
  @validation = session.delete(:validation)
  erb :profile
end

post '/account' do
  authenticated
  user = User[session[:user]]
  user_hash = {}
  params.each do |k,v|
    user_hash[k.to_sym] = v unless k == 're-pass' || k == 'pic' || v.empty?
  end
  puts user_hash
  begin 
    user.update(user_hash)
  rescue Sequel::ValidationFailed => e
    session[:validation] = {'email' => [e.message]}
  end
  redirect "/account"
end
