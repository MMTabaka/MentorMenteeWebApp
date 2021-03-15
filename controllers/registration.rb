require 'sinatra'

get '/' do
  'Hello World!'
end

get '/details' do
  # Only allow if continuing from registration
  redirect '/' unless session[:reg_params]

  # TODO: Complete
  return 'WIP'
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
