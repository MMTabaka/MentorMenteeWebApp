class M_user < Sequel::Model
    
    def self.login(email, password)
        return true if self[email: email][:password] == password
        return false
    end
    
end
