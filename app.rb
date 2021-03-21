require 'require_all'
require 'sinatra'
require 'sinatra/reloader'

enable :sessions

# So we can escape HTML special characters in the view
include ERB::Util

# For Codio
set :bind, '0.0.0.0'

# Sessions
enable :sessions
set :session_secret, "ap*kTBwmtjW!{{]lVEbey926tq8l!j2sb57kMxoF~~TXnHnyyJDkJ"

# Database
require_relative 'db/db'

require_all 'models'
require_all 'controllers'