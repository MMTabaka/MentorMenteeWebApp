def rejection
  connection = get_users[2]
  connection.update(status: 2, active: 0, end_time: Time.now.gmtime.to_s, rejection_reason: @reason)
  redirect '/'
end