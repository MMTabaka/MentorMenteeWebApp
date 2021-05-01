require 'sequel'

class Connection < Sequel::Model
  
  # Function that creates new connection
  def self.add(details_hash)
    connection = Connection.new(details_hash)
    connection.save
  end
  
  # Function that checks if any connection with given user exists
  def self.exist?(user_type, user_id)
    if user_type == UserType::MENTOR
      return true if where(mentor_id: user_id, active: 1).single_record != nil
    elsif user_type == UserType::MENTEE
      return true if where(mentee_id: user_id, active: 1).single_record != nil
    end
    false
  end
  
  
  def self.get()
    return get_users[2]
  end
  
  def self.retrieve(user)
    if user[:user_type] == UserType::MENTOR
      return Connection.where(mentor_id: user[:id], active: 0).all
    elsif user[:user_type] == UserType::MENTEE
      return Connection.where(mentee_id: user[:id], active: 0).all
    end
    nil
  end
end

