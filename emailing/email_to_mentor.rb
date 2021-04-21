require 'email_contact'

class EmailToMentor < Email

  def initialize(mentor_email, mentor_name, mentee_email, mentee_name)
    super(EmailContact(mentor_name, mentor_email),
          EmailContact(Constants::DEFAULT_PLATFORM_SENDER_NAME, Constants::DEFAULT_PLATFORM_EMAIL),
          EmailContact(mentee_name, mentee_email),
          "",
          "")
  end
end