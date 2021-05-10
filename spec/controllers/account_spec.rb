require_relative '../rspec_helper'
require 'rack/test'
require_relative '../../db/db'
require_relative '../../models/user'
require_relative '../../helpers/user_type'
require_relative '../../app'
require_relative '../../controllers/registration'
require_relative '../../controllers/login'
require_relative '../../controllers/account'

RSpec.describe 'Account Tests', type: :controller do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before(:each) do
    # Insert one user into test DB
    base_hash = {
      email: 'test4@email.com',
      password: 'VerySecurePass1337',
      user_type: UserType::MENTEE,
      name: 'Test Name',
      department: 'Desc',
      bio: 'Explanation',
      interest_areas: 'Area 1,Area 2'
    }

    User.create(base_hash)
  end

  after(:each) do
    cleanup
  end
  
  describe 'GET /account', type: :controller do
    context 'when we try and change the email' do
      it 'changes profile details' do
        post '/login', { 'email' => 'test4@email.com', 'pass' => 'VerySecurePass1337' }
        cookie = last_response.cookies['rack.session']
        post '/account', { email: 'TEST@email.com' }
        get '/account', headers: cookie
        expect(last_response.body).to include('TEST@email.com')
      end
    end
    context 'when we try and change the bio' do
      it 'changes profile details' do
        post '/login', { 'email' => 'test4@email.com', 'pass' => 'VerySecurePass1337' }
        cookie = last_response.cookies['rack.session']
        post '/account', { bio: 'Example Bio' }
        get '/account', headers: cookie
        expect(last_response.body).to include('Example Bio')
      end
    end
    context 'when we try and change the department' do
      it 'changes profile details' do
        post '/login', { 'email' => 'test4@email.com', 'pass' => 'VerySecurePass1337' }
        cookie = last_response.cookies['rack.session']
        post '/account', { department: 'Example Department' }
        get '/account', headers: cookie
        expect(last_response.body).to include('Example Department')
      end
    end
    context 'when we try and change the name' do
      it 'changes profile details' do
        post '/login', { 'email' => 'test4@email.com', 'pass' => 'VerySecurePass1337' }
        cookie = last_response.cookies['rack.session']
        post '/account', { name: 'Example Name' }
        get '/account', headers: cookie
        expect(last_response.body).to include('Example Name')
      end
    end
  end
end
