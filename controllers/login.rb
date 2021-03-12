require 'sinatra'

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


get "/" do
    redirect "/login" unless session[:logged_in]
    "Home"
end

get "/login" do
    @validation = { 'valid' => true, 'errors' => {} }
    erb :login
end

post "/login" do
    @email = params["email"]
    @password = params["pass"]
    
    if M_user.login(@email, @password)
        session[:logged_in] = true
        redirect "/temp-user-page"
    end
end

get "/temp-user-page" do
  "You have logged in successfully!"
end

get "/logout" do
  session.clear
  "You have been logged out successfully"
end