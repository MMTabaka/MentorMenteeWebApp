require_relative '../rspec_helper'
require_relative '../../app'
require_relative '../../db/db'
require_relative '../../models/user'
require_relative '../../helpers/user_type'
require 'rack/test'

RSpec.describe 'Admin controller' do
  include Rack::Test::Methods

  let(:app) { Sinatra::Application }

  before(:each) do
    # Insert one user into test DB
    admin_hash = {
      email: 'admin@email.com',
      password: 'Password123',
      user_type: UserType::ADMIN,
      name: 'Test Name',
      department: '',
      bio: '',
      interest_areas: ''
    }
    mentee_hash = {
      email: 'mentee@email.com',
      password: 'Password123',
      user_type: UserType::MENTEE,
      name: 'Test Name',
      department: 'Desc',
      bio: 'Explanation',
      interest_areas: 'Area 1,Area 2'
    }

    User.create(admin_hash)
    User.create(mentee_hash)
  end

  after(:each) do
    #  Clean up the database after each test
    cleanup
  end

  context 'When an admin tries to log in' do
    it 'logs in successfully' do
      post '/admin/login', { 'email' => 'admin@email.com', 'pass' => 'Password123' }
      follow_redirect!
      expect(last_request.url).to match(%r{.*/admin$})
    end
  end
  context 'When another user tries to log in' do
    it 'fails and redirects back to admin login page' do
      post '/admin/login', { 'email' => 'mentee@email.com', 'pass' => 'Password123' }
      follow_redirect!
      expect(last_request.url).to match(%r{.*/admin/login$})
    end
  end
end
