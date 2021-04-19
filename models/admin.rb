require 'sequel'

class Admin < Sequel::Model
  
  def self.login(email, password)
    admin = where(email: email).single_record
    return nil if admin.nil?
    return admin if self[email: email][:password] == password
    nil
  end
  
end