require 'sequel'

class Connection < Sequel::Model
  
  def self.add(details_hash)
    connection = Connection.new(details_hash)
    connection.save
  end
    
end

