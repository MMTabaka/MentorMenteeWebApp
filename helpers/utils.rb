require 'securerandom'

# Various utility methods
module Utils
  module_function

  # Creates a random password with at least 8 chars containing at least one uppercase, lowercase letter and number
  def generate_password
    password = ''
    # Until password contains uppercase, lowercase and number
    until password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/) && password.length >= 8
      password = SecureRandom.urlsafe_base64(8 / (4 / 3))
    end
    password
  end
end
