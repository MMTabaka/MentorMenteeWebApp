require 'sinatra'

def user_redirect(user)
  if user[:user_type] == UserType::MENTOR
    if Connection.exist?(UserType::MENTOR, user[:id]) 
      connection = Connection.where(mentor_id: user[:id], active: 1)
      puts connection[:id][:status]
      case connection[:id][:status]
        when Status::REQUEST 
          redirect '/request-mentor'
        when Status::ACCEPT 
          redirect '/accept-mentor'
        when Status::REJECTED 
          redirect '/request-history'
        when Status::CONNECTED 
          redirect '/connected'
      else
        "puts Redirection didn't work"
      end
    else
      redirect '/request-history'
    end
  elsif user[:user_type] == UserType::MENTEE
    if Connection.exist?(UserType::MENTEE, user[:id])
      connection = Connection.where(mentee_id: user[:id], active: 1)
      puts connection[:id][:status]
      case connection[:id][:status]
        when Status::REQUEST 
          redirect '/request-mentee'
        when Status::ACCEPT 
          redirect '/accept-mentee'
        when Status::REJECTED 
          redirect '/mentors'
        when Status::CONNECTED 
          redirect '/connected'
      else
        "puts Redirection didn't work"
      end
    else
      redirect '/mentors'
    end
  end
end