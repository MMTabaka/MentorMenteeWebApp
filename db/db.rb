require 'logger'
require 'sequel'

# what mode are we in?
type = ENV.fetch('APP_ENV', 'production')

if type == 'test'
  # Import helper methods for testing if we are testing
  require_relative 'test'
  # Provides an empty in-memory DB and helpers for unit testing
  DB = Sequel.sqlite
  populate_tables
else
  # find the path to the database file
  db_path = File.dirname(__FILE__)
  db = "#{db_path}/database.sqlite3"

  # find the path to the log
  log_path = "#{File.dirname(__FILE__)}/../log/"
  log = "#{log_path}/database.log"

  # create log directory if it does not exist
  Dir.mkdir(log_path) unless File.exist?(log_path)

  # set up the production database instance
  DB = Sequel.sqlite(db, logger: Logger.new(log))
end

