require 'sinatra'
require_relative '../helpers/authenticated'

get '/account' do
  authenticated
  user = User[session[:user]]
  @user = user
  @interests = Interest.all
  @departments = Department.all
  session[:validation] = {} if session[:validation].nil?
  @validation = session.delete(:validation)
  erb :profile
end

post '/account' do
  authenticated
  return delete_account if params['delete'] == 'delete'

  user = User[session[:user]]
  user_hash = {}
  params.each do |k, v|
    user_hash[k.to_sym] = v unless k == 're-pass' || v.empty?
  end
  # Prepare interest areas according to DB structure

  if params['areas']
    interests_str = Interest.where_all(id: params['areas'])
                            .map(&:interest)
                            .sort
                            .join(',')
    user_hash.delete(:areas)
    user_hash[:interest_areas] = interests_str
  end
  begin
    user.update(user_hash)
  rescue Sequel::ValidationFailed => e
    session[:validation] = { 'email' => [e.message] }
  end
  redirect '/account'
end

def delete_account
  user = User[session[:user]]
  user.delete
  session.delete(:user)
  redirect '/login'
end
