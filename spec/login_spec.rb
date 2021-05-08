require_relative 'rspec_helper'
require_relative '../db/db'
require_relative '../models/user'

RSpec.describe 'Login function' do
  before(:all) do
    # Insert one user into test DB
    base_hash = {
      email: 'email@email.com',
      password: 'VerySecurePass1337',
      user_type: '1',
      name: 'Test Name',
      department: 'Desc',
      bio: 'Explanation',
      interest_areas: 'Area 1,Area 2'
    }
    User.create(base_hash)
  end
  context 'when you call a registered user' do
    it 'returns the user' do
      expect(User.login('email@email.com', 'VerySecurePass1337')).to eq(User.where(email: 'email@email.com').single_record)
    end
  end

  context 'when you call user with email that is not in database' do
    it 'returns nil' do
      expect(User.login('notemail@email.com', 'password')).to eq(nil)
    end
  end

  context 'When you call user with existing email but wrong password' do
    it 'returns nil' do
      expect(User.login('email@email.com', 'notpassword')).to eq(nil)
    end
  end

  context 'when you call existing email and password but not connected with the same user' do
    it 'returns nil' do
      expect(User.login('email@email.com', 'password6')).to eq(nil)
    end
  end

  context 'when both entries are nil' do
    it 'returns nil' do
      expect(User.login(nil, nil)).to eq(nil)
    end
  end

  context 'When email is nil but password is already in database' do
    it 'returns nil' do
      expect(User.login(nil, 'password')).to eq(nil)
    end
  end

  context 'When password is nil but email is already in database' do
    it 'returns nil' do
      expect(User.login('email@email.com', nil)).to eq(nil)
    end
  end

  context 'entries are empty strings' do
    it 'returns nil' do
      expect(User.login('', '')).to eq(nil)
    end
  end

  context 'When admin is trying to log in using main page' do
    it 'returns nil' do
      expect(User.login('admin@admin.com', 'PassWord123')).to eq(nil)
    end
  end
end