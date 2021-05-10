require_relative '../rspec_helper'
require_relative '../../app'
require_relative '../../db/db'
require_relative '../../models/user'
require_relative '../../helpers/user_type'
require 'rack/test'

RSpec.describe 'Request controller' do
  include Rack::Test::Methods

  let(:app) { Sinatra::Application }

  before(:each) do
    # Insert one user into test DB
    mentor_hash = {
      email: 'mentor@email.com',
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

    @mentor = User.create(mentor_hash)
    @mentee = User.create(mentee_hash)
  end

  after(:each) do
    #  Clean up the database after each test
    cleanup
  end

  context 'When mentee wants to creates a request' do
    it 'Creates a request successfully' do
      post '/login', { 'email' => 'mentee@email.com', 'pass' => 'Password123' }
      post '/request-mentee', { 'mentor_id' => @mentor.id }
      expect(last_request.url).to match(%r{.*/request-mentee$})
    end
  end
  context 'When mentee who already has a mentor visits /request-mentee' do
    it 'It shows mentor name' do
      post '/login', { 'email' => 'mentee@email.com', 'pass' => 'Password123' }
      post '/request-mentee', { 'mentor_id' => @mentor.id }
      get '/request-mentee'
      expect(last_response.body).to include(@mentor.name)
    end
  end
  context 'When mentee who doesnt have a mentor visits /request-mentee' do
    it 'It redirects away from it' do
      post '/login', { 'email' => 'mentee@email.com', 'pass' => 'Password123' }
      get '/request-mentee'
      expect(last_response.status).to be 500
    end
  end
end

