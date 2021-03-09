require_relative '../models/model'
require_relative '../db/db'

RSpec.describe M_user do
  # TODO: Also check whether actual table is created
  context 'when you call register with new user email and password' do
    it 'creates a new user in DB and returns the instance of it' do
      expect(M_user.register('email@test.com', 'SecurePass123', 0)).to be_an_instance_of(M_user)
    end
  end
  context "when you call register with existing user's email" do
    it 'return nil and does not make any changes to DB' do
      expect(M_user.register('existing@test.com', 'SecurePass123', 0)).to be_nil
    end
  end
end

