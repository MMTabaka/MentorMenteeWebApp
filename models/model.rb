require 'sequel'

class M_user < Sequel::Model
  plugin :validation_helpers
  # Validates user fields
  # Regex from https://digitalfortress.tech/tricks/top-15-commonly-used-regex/
    
  def validate
    super
    validates_presence [:email, :password, :user_type], message: 'Field cannot be empty'
    validates_format /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/, :email, message: 'Email is not valid'
    validates_format /(?=(.*[0-9]))((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.{8,}$/, :password,
                     message: 'Must be at least 8 characters long and contain a lowercase, uppercase letter and a number'
    validates_includes [0, 1, 2], :user_type, message: 'User type is non-existing'

  end
    

  # Checks if the user exists and then checks if the password is correct
  # @param email
  # @param password
  # @return boolean true if the credentials are correct
  def self.login(email, password)
    user = self.where(email: email).single_record
    return nil if user.nil?
    return user if self[email: email][:password] == password
    nil
  end
  

  # Checks if user exists and creates a new one if not
  # @param email email address in valid format
  # @param password plaintext password
  # @param user_type type of the user
  # @return new instance or nil if user already exists
  def self.register(email, password, user_type)
    if M_user.where(email: email).single_record.nil?
      begin
        return M_user.new(email: email, password: password, user_type: user_type).save
      rescue Sequel::ValidationFailed
        return nil
      end
    end

    nil
  end

  # Returns all user information for a given user_type
  # @param user_type An integer representation of the user's role
  def self.retrieveUsers(user_type)
    return  M_user.where(user_type: user_type).all
  end
end
