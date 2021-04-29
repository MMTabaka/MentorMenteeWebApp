
def get_users()
  user = User[session[:user]]
  
  if user[:user_type] == UserType::MENTOR
    mentor = user
    connection = Connection.where(mentor_id: mentor[:id], active: 1)
    mentee = User.where(id: connection[:id][:mentee_id])
  elsif user[:user_type] == UserType::MENTEE
    mentee = user
    connection = Connection.where(mentee_id: mentee[:id], active: 1)
    mentor = User.where(id: connection[:id][:mentor_id])
  end
  
  return [mentor, mentee, connection]
end