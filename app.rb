require 'require_all'
require 'sinatra'
require 'sinatra/reloader'

# So we can escape HTML special characters in the view
include ERB::Util

# For Codio
set :bind, '0.0.0.0'

# Database
require_relative 'db/db'

require_all 'models'
require_all 'controllers'

