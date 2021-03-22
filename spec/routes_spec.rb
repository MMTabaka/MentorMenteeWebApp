require "rspec"
require "rack/test"

require_relative "../controllers/registration"
require_relative "../controllers/login"

RSpec.describe "Routes Tests" do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  describe "GET /login" do
    it "has a status code of 200 (OK)" do
      get "/login"
      expect(last_response.status).to eq(200)
    end
  end
end