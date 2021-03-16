require_relative '../db/test'
require_relative '../models/model'

RSpec.describe M_user do
  after(:each) do
    #  Clean up the database after each test
    cleanup
  end
  base_hash = {
    email: 'valid@email.com',
    password: 'SecurePass123',
    user_type: '1',
    name: 'Test Name',
    department: 'Desc',
    bio: 'Explanation',
    interest_areas: 'Area 1, Area 2'
  }
  describe 'Data validation' do
    context 'when you provide valid data' do
      it 'passes validation' do
        expect(M_user.new(base_hash).valid?).to be(true)
      end
    end
    context 'when you trying to login with existing email' do
      it 'does not pass the validation' do
        M_user.create(base_hash)
        expect(M_user.new(base_hash).valid?).to be(false)
      end
    end
  end
  describe 'Account registration' do
    context 'when you call register with new user email and password' do
      it 'creates a new user in DB and returns the instance of it' do
        expect(M_user.register(base_hash)).to be_an_instance_of(M_user)
      end
    end
  end
  describe 'Retrieving users' do
    context 'when you retrieve all users for a given user_type' do
      it 'returns an array of M_user objects for the specified user_type' do
        M_user.create(email: 'user0@email.com', password: 'SecurePass123', user_type: 0)
        M_user.create(email: 'user1@email.com', password: 'SecurePass123', user_type: 1)
        M_user.create(email: 'user2@email.com', password: 'SecurePass123', user_type: 1)
        expect(M_user.retrieveUsers(1).count).to be == 2
      end
    end
  end
  describe 'Account login' do
    
end

