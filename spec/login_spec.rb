require_relative '../db/db'
require_relative '../models/user'

RSpec.describe 'Login function' do
  context 'when you call a registered user' do
    it 'returns true' do
      expect(User.login('email@email.com', 'password')).to eq(true)
    end
  end

  context 'when you call user with email that is not in database' do
    it 'returns false' do
      expect(User.login('notemail@email.com', 'password')).to eq(false)
    end
  end

  context 'When you call user with existing email but wrong password' do
    it 'returns false' do
      expect(User.login('email@email.com', 'notpassword')).to eq(false)
    end
  end

  context 'when you call existing email and password but not connected with the same user' do
    it 'returns false' do
      expect(User.login('email@email.com', 'password6')).to eq(false)
    end
  end

  context 'when both entries are nil' do
    it 'returns false' do
      expect(User.login(nil, nil)).to eq(false)
    end
  end

  context 'When email is nil but password is already in database' do
    it 'returns false' do
      expect(User.login(nil, 'password')).to eq(false)
    end
  end

  context 'When password is nil but email is already in database' do
    it 'returns false' do
      expect(User.login('email@email.com', nil)).to eq(false)
    end
  end

  context 'entries are empty strings' do
    it 'returns false' do
      expect(User.login('', '')).to eq(false)
    end
  end
end
