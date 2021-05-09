# funtion that return returns array of mentor, mentee and just another user instances based
# on connection and connection itself
def get_users
  user = User[session[:user]]
  case user[:user_type]
  when UserType::MENTOR
    mentor = user
    connection = Connection.where(mentor_id: mentor[:id], active: 1)
    mentee = User.where(id: connection[:id][:mentee_id])
    connected_user = mentee
  when UserType::MENTEE
    mentee = user
    connection = Connection.where(mentee_id: mentee[:id], active: 1)
    mentor = User.where(id: connection[:id][:mentor_id])
    connected_user = mentor
  else
    return nil
  end
  [mentor, mentee, connection, connected_user]
end
