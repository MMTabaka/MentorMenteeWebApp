require 'sib-api-v3-sdk'
require 'email_contact'
# Represents email to be sent using SendinBlue API
class Email
  attr_reader :contact_to, :contact_from, :contact_reply_to, :subject, :body

  API_KEY = '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'.freeze

  # Creates a new email. For now all parameters are required and they cannot be changed later.
  # @param [EmailContact] contact_to name and email of recipient
  # @param [EmailContact] contact_from name and email of sender
  # @param [EmailContact] contact_reply_to name and email of reply-to contact
  # @param [String] subject email subject
  # @param [String] body email contents - can contain HTML
  def initialize(contact_to, contact_from, contact_reply_to, subject, body)
    @contact_to = contact_to
    @contact_from = contact_from
    @contact_reply_to = contact_reply_to
    @subject = subject
    @body = body
    @api = config_api
    @email = setup_email
  end

  # Sends the email
  def send
    raise StandardError 'Email details are invalid' unless @email.valid?

    @api.send_transac_email(@email)
  rescue SibApiV3Sdk::ApiError => e
    puts "Exception while trying to send an email: #{e}"
  end

  private

  # Configures API credentials. In production, shouldn't be hardcoded here
  def config_api
    SibApiV3Sdk.configure do |config|
      # Configure API key authorization: api-key
      config.api_key['api-key'] = API_KEY
      # Configure API key authorization: partner-key
      config.api_key['partner-key'] = API_KEY
    end
    SibApiV3Sdk::TransactionalEmailsApi.new
  end

  # Sets up email with provided details
  def setup_email
    email = SibApiV3Sdk::SendSmtpEmail.new
    email.sender = SibApiV3Sdk::SendSmtpEmailSender.new(@contact_from.to_h)
    email.to = [SibApiV3Sdk::SendSmtpEmailTo.new(@contact_to.to_h)]
    email.reply_to = SibApiV3Sdk::SendSmtpEmailReplyTo.new(@contact_reply_to.to_h)
    email.subject = @subject
    email.text_content = @body
    email
  end
end
