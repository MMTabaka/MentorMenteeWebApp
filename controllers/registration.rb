require 'sinatra'

get '/details' do
  # Only allow if continuing from registration
  redirect '/' unless session[:reg_params]
  @user_type = session[:reg_params][:user_type]

  erb :addInfo
end

post '/details' do
  # Cookie is gone?
  halt 500 unless session[:reg_params]
  usr_details = {
    email: session[:reg_params][:email],
    password: session[:reg_params][:password],
    user_type: session[:reg_params][:user_type],
    name: params['name'],
    department: params['department'],
    bio: params['bio'],
    interest_areas: params['areas']
  }
  user = User.register(usr_details)
  # Account creation successful, log in new user
  session[:reg_params] = nil
  session[:user] = user.id
  puts "Registration successful: #{user.id}"
  redirect '/'
end

get '/registration' do
  # Initialise validation if it's not set yet
  session[:validation] = {} if session[:validation].nil?
  @validation = session.delete(:validation)
  erb :registration
end

post '/registration' do
  puts params
  if params['pass'] == params['re-pass']
    # Create instance just for validation for now
    user = User.new(email: params['email'], password: params['pass'], user_type: params['user-type'])
    unless user.valid?
      # Validations failed
      session[:validation] = user.errors
      redirect '/registration'
    end
    # Registration successful, let's continue by saving
    # stuff we have for later
    session[:reg_params] = { email: params['email'], password: params['pass'], user_type: params['user-type'] }
    # Clear validation just in case
    session[:validation]
    redirect '/details'
  end
  session[:validation] = { re_pass: 'Passwords do not match' }
  redirect '/registration'
end
