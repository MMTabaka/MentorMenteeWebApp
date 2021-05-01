require_relative 'rspec_helper'
require_relative '../db/db'
require_relative '../models/user'
require_relative '../helpers/user_type.rb'

RSpec.describe User do
  after(:each) do
    #  Clean up the database after each test
    cleanup
  end
  base_hash = {
    email: 'valid@email.com',
    password: 'SecurePass123',
    user_type: UserType::MENTOR,
    name: 'Test Name',
    department: 'Desc',
    bio: 'Explanation',
    interest_areas: 'Area 1,Area 2'
  }
  describe 'Data validation' do
    context 'when you provide valid data' do
      it 'passes validation' do
        expect(User.new(base_hash).valid?).to be(true)
      end
    end
    context 'when you trying to login with existing email' do
      it 'does not pass the validation' do
        User.create(base_hash)
        expect(User.new(base_hash).valid?).to be(false)
      end
    end
  end
  describe 'Account registration' do
    context 'when you call register with new user email and password' do
      it 'creates a new user in DB and returns the instance of it' do
        expect(User.register(base_hash)).to be_an_instance_of(User)
      end
    end
  end
  describe 'Retrieving users' do
    context 'when you retrieve all users for a given user_type' do
      it 'returns an array of M_user objects for the specified user_type' do
        User.create(email: 'user0@email.com', password: 'SecurePass123', user_type: UserType::MENTEE)
        User.create(email: 'user1@email.com', password: 'SecurePass123', user_type: UserType::MENTOR)
        User.create(email: 'user2@email.com', password: 'SecurePass123', user_type: UserType::MENTOR)
        expect(User.retrieve_users(UserType::MENTOR).count).to be == 2
      end
    end
  end
  describe 'Mentee / Mentor comparison' do
    context 'when you compare two users with the same interests' do
      it 'returns an integer value of interests that are the same (3)' do
        mentee = User.create(email: 'user0@email.com', password: 'SecurePass123', user_type: UserType::MENTEE, interest_areas: "field1,field2,field3")
        mentor = User.create(email: 'user1@email.com', password: 'SecurePass123', user_type: UserType::MENTOR, interest_areas: "field1,field2,field3")
        expect(mentee.match_factor(mentor)).to be == 3
      end
    end
    context 'when you compare two users with different interests' do
      it 'returns an integer value of interests that are the same (2)' do
        mentee = User.create(email: 'user0@email.com', password: 'SecurePass123', user_type: UserType::MENTEE, interest_areas: "field1,field2,field3")
        mentor = User.create(email: 'user1@email.com', password: 'SecurePass123', user_type: UserType::MENTOR, interest_areas: "field1,field2,not field")
        expect(mentee.match_factor(mentor)).to be == 2
      end
    end
  end
end

