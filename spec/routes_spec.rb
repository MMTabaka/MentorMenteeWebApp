require 'rspec'
require 'rack/test'
require_relative '../app'
require_relative '../controllers/registration'
require_relative '../controllers/login'

RSpec.describe 'Routes Tests' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before(:each) do
    app.set :views, (proc { File.join(root, 'views') })
  end
    
    describe 'GET /' do
    it 'has a status code of 302' do
      get '/'
      l = last_response
      expect(l.status).to eq(302)
    end
  end

  describe 'GET /login' do
    it 'has a status code of 200 (OK)' do
      get '/login'
      expect(last_response.status).to eq(200)
    end
  end
  
  describe 'GET /registration' do
    it 'has a status code of 200 (OK)' do
      get '/registration'
      expect(last_response.status).to eq(200)
    end
  end
end