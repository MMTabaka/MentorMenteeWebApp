require_relative 'email_to_mentor'
require_relative 'password_reset_email'

# Run this file with your email to test email sending manually.
# Note: don't push your email to Git!
YOUR_EMAIL = ''
YOUR_NAME = ''

to_mentor = EmailToMentor.new(YOUR_EMAIL, YOUR_NAME, 'mentee@email.com', 'John Doe')
reset_pass = PasswordResetEmail.new(YOUR_NAME, YOUR_EMAIL, 'tempPass123')

puts to_mentor.send
puts reset_pass.send
