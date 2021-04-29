def rejection
  connection = get_users[2]
  connection.update(status: 2, active: 0)
  redirect '/'
end