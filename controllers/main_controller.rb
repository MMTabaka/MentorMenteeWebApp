get "/" do
  u = M_user.register("new@email.com", "Pass", 1)
  u.to_s
end
