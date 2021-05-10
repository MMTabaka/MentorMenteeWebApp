require 'simplecov'
require 'rspec'
require 'webmock/rspec'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/db/'
end

# Disables all external network traffic
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    # Stub email API requests to be always successfull
    stub_request(:any, 'https://api.sendinblue.com/v3/smtp/email')
      .to_return(status: 200, body: '', headers: {})
  end
end
ENV['APP_ENV'] = 'test'
