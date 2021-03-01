require "logger"
require "sequel"

type = ENV.fetch("APP_ENV", "users")

db_path = File.dirname(__FILE__)
db = "#{db_path}/#{type}.sqlite3"

log_path = "#{File.dirname(__FILE__)}/../log/"
log = "#{log_path}/#{type}.log"

Dir.mkdir(log_path) unless File.exist?(log_path)

DB = Sequel.sqlite(db, logger: Logger.new(log))