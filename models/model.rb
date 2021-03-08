class M_user < Sequel::Model
    def self.email_exists?(email)
        return false if email.nil?
        return false if M_user[email].nil?
        true
    end
end
