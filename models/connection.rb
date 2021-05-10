require 'sequel'

# Model representing connections between users and possible actions
class Connection < Sequel::Model
  # Function that creates new connection
  def self.add(details_hash)
    connection = Connection.new(details_hash)
    connection.save
  end

  # Function that checks if any connection with given user exists
  def self.exist?(user_type, user_id)
    case user_type
    when UserType::MENTOR
      return true if where(mentor_id: user_id, active: 1).single_record != nil
    when UserType::MENTEE
      return true if where(mentee_id: user_id, active: 1).single_record != nil
    end
    false
  end

  # Function that returns connection
  def self.get
    get_users[2]
  end

  # Funtion that returns all inactive connection in which particular user was involved
  def self.retrieve(user)
    case user[:user_type]
    when UserType::MENTOR
      return Connection.where(mentor_id: user[:id], active: 0).all
    when UserType::MENTEE
      return Connection.where(mentee_id: user[:id], active: 0).all
    end

    nil
  end
end
