require 'sequel'
require_relative '../helpers/utils'
require_relative '../emailing/password_reset_email'

# Model representing user record and its related actions
class User < Sequel::Model
  plugin :validation_helpers
  # Validates user fields
  # Regex from https://digitalfortress.tech/tricks/top-15-commonly-used-regex/
  def validate
    super
    validates_presence [:email, :password, :user_type], message: 'Field cannot be empty'
    validates_format /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$/, :email, message: 'Email is not valid'
    validates_format /(?=(.*[0-9]))((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.{8,}$/, :password,
                     message: 'Must be at least 8 characters long and contain a lowercase, uppercase letter and a number'
    validates_includes [UserType::MENTOR, UserType::MENTEE, UserType::ADMIN], :user_type,
                       message: 'User type is non-existing'
    validates_unique(:email, message: 'This email is already taken')

  end

  # Checks if the user exists and then checks if the password is correct
  # @param email
  # @param password
  # @return boolean true if the credentials are correct
  def self.login(email, password, admin: false)
    user = where(email: email).single_record
    return nil if user.nil?
    
    if self[email: email][:suspension] == 1
      return nil
    end

    if self[email: email][:password] == password
      return nil if self[email: email][:user_type] == UserType::ADMIN && !admin
      return user
    end
    nil
  end

  # Checks if user exists and creates a new one if not
  # @param details_hash hash with all fields in the model
  # @return new instance of the user (might be nil if validation fails)
  def self.register(details_hash)
    user = User.new(details_hash)
    user.save if user.valid?
    user
  end

  # Returns all user information for a given user_type
  # @param user_type An integer representation of the user's role
  def self.retrieve_users(user_type)
    User.where(user_type: user_type).all
  end

  # Returns the levenshtein distance between a mentor and mentee's interests
  # @param mentor_fields An unsplit array of the mentor's interests
  # @param mentee_fields An unsplit array of the mentee's interests
  def self.levenshtein_distance(mentor_fields, mentee_fields)
    '''
    Levenshtein distance implementation from Rosetta code:
    https://rosettacode.org/wiki/Levenshtein_distance#Ruby
    '''
    if mentor_fields.nil? || mentee_fields.nil?
      return nil
    end

    mentor_fields_array = mentor_fields.split(', ')
    mentee_fields_array = mentee_fields.split(', ')

    costs = Array(0..mentee_fields_array.length) # i == 0
    (1..mentor_fields_array.length).each do |i|
      costs[0], nw = i, i - 1  # j == 0; nw is lev(i-1, j)
      (1..mentee_fields_array.length).each do |j|
        costs[j], nw = [costs[j] + 1, costs[j - 1] + 1, mentor_fields_array[i - 1] == mentee_fields_array[j - 1] ? nw : nw + 1].min, costs[j]
      end
    end
    return costs[mentee_fields_array.length]
  end

  # Toggles user's suspension status
  def toggle_suspension
    update(suspension: (Sequel[:suspension] + 1) % 2)
  end

  def reset_password
    new_password = Utils.generate_password
    email = PasswordResetEmail.new(self[:name], self[:email], new_password)
    begin
      email.send
      update(password: new_password)
      puts 'Email reset complete.'
    rescue EmailSendError, InvalidEmailError => e
      puts "Could not reset password: #{e}"
    end
  end

  # Returns the number of same interests between mentee and mentor
  # @param mentor Mentor to be compared against
  # @return number of same interests between mentee and mentor
  def match_factor(mentor)
    mentee_fields = self[:interest_areas].split(',')
    mentor_fields = mentor[:interest_areas].split(',')
    same_fields = (mentee_fields & mentor_fields).length
    return same_fields
  end
end