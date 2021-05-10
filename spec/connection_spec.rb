require_relative 'rspec_helper'
require_relative '../app'
require_relative '../db/db'
require_relative '../models/user'
require_relative '../helpers/user_type'
require 'rack/test'


RSpec.describe 'Connection' do
  after(:each) do
    #  Clean up the database after each test
    cleanup
  end
  mentee_hash = {
    email: 'email1@email.com',
    password: 'Password123',
    user_type: UserType::MENTEE,
    name: 'Test Name',
    department: 'Desc',
    bio: 'Explanation',
    interest_areas: 'Area 1,Area 2'
  }

  mentor_hash = {
    email: 'email2@email.com',
    password: 'Password123',
    user_type: UserType::MENTOR,
    name: 'Test Name',
    department: 'Desc',
    bio: 'Explanation',
    interest_areas: 'Area 1,Area 2'
  }

  mentee = User.create(mentee_hash)
  mentor = User.create(mentor_hash)

  connection_hash = {
    mentee_id: mentee[:id],
    mentor_id: mentor[:id],
    status: 0,
    active: 1,
    request_time: Time.now.gmtime.to_s
  }
  context 'When connection has not been created for mentor' do
    it 'returns false' do
      expect(Connection.exist?(0, mentor[:id])).to be(false)
    end
  end

  context 'When connection has not been created for mentee' do
    it 'returns false' do
      expect(Connection.exist?(1, mentee[:id])).to be(false)
    end
  end

  context 'When you want to check if connection has been created for mentor' do
    it 'returns true' do
      Connection.create(connection_hash)
      expect(Connection.exist?(0, mentor[:id])).to be(true)
    end
  end

  context 'When you want to check if connection has been created for mentee' do
    it 'returns true' do
      Connection.create(connection_hash)
      expect(Connection.exist?(1, mentee[:id])).to be(true)
    end
  end

  # context 'When you want to get the connection' do
  # it 'returns true' do
  # x = Connection.create(connection_hash)
  # request.session[:user] = mentor
  # expect (Connection.get() == x).to be(true)
  # end
  # end

  context 'When you call Connection.add' do
    it 'Adds new connection to the DB' do
      Connection.add(connection_hash)
      expect(DB[:connections].count).to be 1
    end
  end

  context 'When you want to retrieve inactive connections' do
    it 'for mentor returns 2' do
      Connection.create(connection_hash)
      Connection.create(connection_hash)
      Connection.create(mentee_id: mentee[:id], mentor_id: mentor[:id], active: 0, status: 2)
      Connection.create(mentee_id: mentee[:id], mentor_id: mentor[:id], active: 0, status: 2)
      expect(Connection.retrieve(mentor).count).to be == 2
    end
    it 'for mentee returns 2' do
      Connection.create(connection_hash)
      Connection.create(connection_hash)
      Connection.create(mentee_id: mentee[:id], mentor_id: mentor[:id], active: 0, status: 2)
      Connection.create(mentee_id: mentee[:id], mentor_id: mentor[:id], active: 0, status: 2)
      expect(Connection.retrieve(mentee).count).to be == 2
    end
  end
end
