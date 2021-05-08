require_relative 'email_contact'
require_relative 'email'
require_relative '../helpers/consts'

# Represents email to notify mentor of new request
class EmailToMentor < Email



  def initialize(mentor_email, mentor_name, mentee_email, mentee_name)
    @subject_template = '%{name} wants to be your mentee!'
    @body_template = 'Hi!<br/>%{name} has just sent you a request to become their mentor. '\
                     'You can reach out directly by replying to this email or writing to <b>%{email}</b>.'

    super(EmailContact.new(mentor_name, mentor_email),
          EmailContact.new(Constants::DEFAULT_PLATFORM_SENDER_NAME, Constants::DEFAULT_PLATFORM_EMAIL),
          format(@subject_template, name: mentee_name),
          format(@body_template, name: mentee_name, email: mentee_email),
          EmailContact.new(mentee_name, mentee_email))
  end
end
