require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"


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

get '/mentorList' do
  pic = "defaultPic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentee";
  @requesting = false;
  @actived = "mentorList";
  @username = "sflk asfakdsj";
  @email = "sdfh@lsdkf";
  @department = "dfsf";
  @area = "asfaf,alsj lfsldkjfo, asdlkjf sdfks";
  @bio = "asasfasdascxcvzfdbzgnmhmdyhsfasd";
  @mentors = 5;
  @userID = "234";
  erb :mentorList
end

post '/mentorList' do
  puts params
  val = validate(params)
  return redirect '/'
  @validation = val
  erb :mentorList
end

get '/profile' do
  pic = "defaultPic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @pic = "img/" + pic;
  @userType = "Mentor";
  @requesting = false;
  @userPic = "img/" + pic;
  @actived = "requestHistory";
  @username = "";
  @email = "sdfh@lsdkf";
  @department = "dfsf";
  @area = "asfaf";
  @bio = "asasfasdascxcvzfdbzgnmhmdyhsfasd";
  erb :profile
end

post '/profile' do
  puts params
  val = validate(params)
  return redirect '/'
  @validation = val
  erb :profile
end

get '/addInfo' do
  pic = "pic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentor";
  @requesting = false;
  @userPic = "img/" + pic;
  @actived = "requestHistory"
  erb :addInfo
end

post '/addInfo' do
  puts params
  val = validate(params)
  return redirect '/login'
  @validation = val
  erb :addInfo
end

get '/registration' do
  pic = "pic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentee";
  @requesting = false;
  @userPic = "img/" + pic;
  @actived = "requestHistory"
  erb :registration
end

post '/registration' do
  puts params
  val = validate(params)
  return redirect '/addInfo' if val['valid']
  @validation = val
  erb :registration
end

get '/login' do
  pic = "pic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentee";
  @requesting = false;
  @userPic = "img/" + pic;
  @actived = "requestHistory"
  erb :login
end

post '/login' do
  puts params
  val = validate(params)
  return redirect '/' if val['valid']
  @validation = val
  erb :login
end

get '/requestingmentee' do
  pic = "pic.jpg"
  @validation = { 'valid' => true, 'errors' => {} }
  @loggedIn = true;
  @userType = "Mentee";
  @requesting = false;
  @userPic = "img/" + pic;
  @actived = "requestHistory"
  @username = "xxxxxxx"; 
  @department = "xxxxxxx"
  @email = "sdfh@lsdkf";
  @status = "xxxxxxxxxxxxxxxxxxxx";
  @area = "asfaf";
  @bio = "asasfasdascxcvzfdbzgnmhmdyhsfasd";
  @time = "xxxxxx"  
  erb :requestingmentee
end

post '/requestingmentee' do
  puts params
  val = validate(params)
  return redirect '/' if val['valid']
  @validation = val
  erb :requestingmentee
end

