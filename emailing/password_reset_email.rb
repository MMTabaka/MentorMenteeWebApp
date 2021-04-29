require_relative 'email_contact'
require_relative 'email'
require_relative '../helpers/consts'

# Represents email to reset the password
class PasswordResetEmail < Email


  def initialize(name, email, new_password)
    @subject_template = 'Password change has been requested'
    @body_template = 'Hi!<br/>Your new temporary password is <b>%{password}</b>. Make sure to change it after logging in.'

    super(EmailContact.new(name, email),
          EmailContact.new(Constants::DEFAULT_PLATFORM_SENDER_NAME, Constants::DEFAULT_PLATFORM_EMAIL),
          @subject_template,
          format(@body_template, password: new_password))
  end
end
