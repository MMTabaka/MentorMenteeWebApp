require_relative '../rspec_helper'
require 'rack/test'
require_relative '../../db/db'
require_relative '../../models/user'
require_relative '../../helpers/user_type'
require_relative '../../app'
require_relative '../../controllers/registration'
require_relative '../../controllers/login'
require_relative '../../controllers/account'

RSpec.describe "Account Tests", type: :controller do
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
    
    # Example param hash
    # params = {
    #   "name"=>"",
    #   "email"=>"email@email.com",
    #   "password"=>"", "re-pass"=>"",
    #   "department"=>"Department of Computer Science",
    #   "areas"=>["9", "21", "34"],
    #   "bio"=>" "}

    User.create(base_hash)
    
  end
  # after(:each) do
  #   User.destroy
  # end
  describe 'GET /account', :type => :controller do
    it 'changes profile details' do
      params = {
        'email' => 'TEST@email.com'
      }
      
      # cookies['rack.session'] = cookie
      post '/login', {'email'=>"test4@email.com", 'pass'=>"VerySecurePass1337"}
      cookie = last_response.cookies['rack.session']
      post '/account', params: {:email => 'TEST@email.com'}, headers: cookie
      get '/account', headers: cookie
      expect(last_response.body).to include(params['email'])

      # expect(last_response.status).to eq(200)
    end
  end
end