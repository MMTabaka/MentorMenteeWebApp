require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"

get '/userInfo' do
  @username = "Mia Aka"
  @email = "abcdb@fsef.com"
  erb :userInfo
end

def validate(user_data)
  res = { 'valid' => true, 'errors' => {} }
  # Validate email address
  if user_data['email'].nil?
    res['valid'] = false
    res['errors']['email'] = 'Please enter your email'
    return res
  elsif !user_data['email'].match?(/^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/)
    res['valid'] = false
    res['errors']['email'] = 'Invalid email'
  end
  # Validate password
  if user_data['pass'].nil?
    res['valid'] = false
    res['errors']['pass'] = 'Please enter your password'
    return res
  # Password must be 8 chars long, contain lower, upper-case letters and numbers
  elsif !user_data['pass'].match?(/(?=(.*[0-9]))((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.{8,}$/)
    res['valid'] = false
    # TODO: This is too long i guess
    res['errors']['pass'] = 'Must be at least 8 characters long and contain a lowercase, uppercase letter and a number'
  end
  if user_data['re-pass'].nil?
    res['valid'] = false
    res['errors']['re-pass'] = 'Please retype your password'
    return res
  elsif user_data['re-pass'] != user_data['pass']
    res['valid'] = false
    res['errors']['re-pass'] = 'Passwords do not match'
  end
  if user_data['user-type'].nil?
    res['valid'] = false
    res['errors']['user-type'] = 'Please enter your email'
    return res
  # If this happened, user tampered with input
  elsif user_data['user-type'] != '1' && user_data['user-type'] != '2'
    res['valid'] = false
    res['errors']['user-type'] = 'Non-existing user type'
  end
  res
end


get '/' do
  'Hello World!'
end

get '/registration' do
  pic = "pic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentee";
  @requesting = false;
  @userPic = "img/" + pic;
  @activedM = ""
  @activedRH = "active"
  @activedLI = ""
  erb :registration
end

post '/registration' do
  puts params
  val = validate(params)
  return redirect '/' if val['valid']
  @validation = val
  erb :registration
end