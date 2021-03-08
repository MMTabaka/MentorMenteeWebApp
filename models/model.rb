class M_user < Sequel::Model
    
    def self.login(email, password)
        return false if email.nil?
        return false if password.nil?
        #return false if self[:email].nil?
        #return false if self[:password].nil?
        return false if self[email: email][:password].nil?
        return true if self[email: email][:password] == password
        return false
    end
    
end
