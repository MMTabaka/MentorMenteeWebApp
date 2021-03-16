require_relative '../models/model'
require_relative '../db/db'

RSpec.describe "Login function" do
    
    context "checks first user login and password" do
        it "returns true" do
            expect(M_user.login("email@email.com", "password")).to eq(true)
        end
    end
end