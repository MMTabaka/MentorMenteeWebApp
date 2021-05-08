require 'simplecov'
require 'rspec'

SimpleCov.start do
  add_filter '/spec/'
end

ENV['APP_ENV'] = 'test'

