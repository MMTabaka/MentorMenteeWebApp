require 'sequel'

class Connection < Sequel::Model
  
  def self.add(details_hash)
    connection = Connection.new(details_hash)
    connection.save
  end
  
  def self.get_status()
  end
  
  def self.exist?(user_type, user_id)
    if user_type == UserType::MENTOR
      return true if where(mentor_id: user_id).single_record != nil && self[mentor_id: user_id][:status] != 2
    elsif user_type == UserType::MENTEE
      return true if where(mentee_id: user_id).single_record != nil && self[mentee_id: user_id][:status] != 2
    end
    false
  end
    
end

