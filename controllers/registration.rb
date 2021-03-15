require 'sinatra'

get '/' do
  'Hello World!'
end

get '/details' do
  # Only allow if continuing from registration
  redirect '/' unless session[:reg_params]
  @userType = session[:reg_params][:user_type]

  erb :addInfo
end

post '/details' do
  # Cookie is gone?
  halt 500 unless session[:reg_params]
  usr_details = {
    email: session[:reg_params][:email],
    password: session[:reg_params][:password],
    user_type: session[:reg_params][:user_type],
    description: params['department'],
    explanation: params['bio'],
    fields: params['areas']
  }
  user = M_user.register(usr_details)
  # Account creation successful, log in new user
  session[:reg_params] = nil
  session[:user] = user
  redirect '/'
end

get '/registration' do
  @validation = {}
  erb :registration
end

post '/registration' do
  puts params
  if params['pass'] == params['re-pass']
    # Create instance just for validation for now
    user = M_user.new(email: params['email'], password: params['pass'], user_type: params['user-type'])
    unless user.valid?
      # Validations failed
      @validation = user.errors
      # TODO: This is not ideal, I should redirect, but then I need to save validation to session?
      return erb :registration
    end
    # Registration successful, let's continue by saving
    # stuff we have for later
    session[:reg_params] = { email: params['email'], password: params['pass'], user_type: params['user-type'] }
    return redirect '/details'
  end
  @validation = { re_pass: 'Passwords do not match' }
  return erb :registration
end
