require 'sequel'

class M_user < Sequel::Model
    # Checks if the user exists and then checks if the password is correct
    
    def self.login(email, password)
        return false if email.nil?
        return false if password.nil?
        
        if self.where(email: email).single_record.nil?
            return false
        else
            return true if self[email: email][:password] == password
            return false if self[email: email][:password].nil?
        end
        return false
    end
    

  # Checks if user exists and creates a new one if not
  # @param email email address in valid format
  # @param password plaintext password
  # @param user_type type of the user
  # @return new instance or nil if user already exists
  def self.register(email, password, user_type)
    if M_user.where(email: email).single_record.nil?
      return M_user.create(email: email, password: password, user_type: user_type)
    end

    nil
  end
end
