require 'sinatra'

get '/' do
  'Hello World!'
end

get '/registration' do
  @validation = nil
  erb :registration
end

post '/registration' do
  if params['pass'] == params['repass']
    user = M_user.register(params['email'], params['pass'], params['user-type'])
    unless user.nil?
      if user.valid?
        return redirect '/' if val['valid']
      end
      @validation = user.errors
      erb :registration
    end
    @validation = { email: 'User already exists' }
    erb :registration
  end
  @validation = { re_pass: 'Passwords do not match' }
  erb :registration
end
