require 'sinatra'

def user_redirect(user)
  if user[:user_type] == UserType::MENTOR
    if Connection.exist?(UserType::MENTOR, user[:id]) 
      case Connection[mentor_id: user[:id]][:status]
        when Status::REQUEST 
          redirect '/temp-user-page'
        when Status::ACCEPT 
          redirect '/temp-user-page'
        when Status::REJECTED 
          redirect '/temp-user-page'
        when Status::CONNECTED 
          redirect '/temp-user-page'
      else
        "puts Redirection didn't work"
      end
    else
      redirect '/temp-user-page'
    end
  elsif user[:user_type] == UserType::MENTEE
    if Connection.exist?(UserType::MENTEE, user[:id]) 
      case Connection[mentee_id: user[:id]][:status]
        when Status::REQUEST 
          redirect '/request'
        when Status::ACCEPT 
          redirect '/temp-user-page'
        when Status::REJECTED 
          redirect '/temp-user-page'
        when Status::CONNECTED 
          redirect '/temp-user-page'
      else
        "puts Redirection didn't work"
      end
    else
      redirect '/mentors'
    end
  end
end