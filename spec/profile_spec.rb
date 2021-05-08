require_relative 'rspec_helper'
require_relative '../db/db'
require_relative '../models/user'

RSpec.describe 'Login function' do
  before(:all) do
    # Insert one user into test DB
    base_hash = {
      email: 'email@email.com',
      password: 'VerySecurePass1337',
      user_type: UserType::MENTEE,
      name: 'Test Name',
      department: 'Desc',
      bio: 'Explanation',
      interest_areas: 'Area 1,Area 2'
    }
    User.create(base_hash)
    User.login('email@email.com', 'VerySecurePass1337')
  end
  #context 'TODO' do
    #it 'blank' do
      
    #end
  #end
end