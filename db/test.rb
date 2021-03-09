require 'sequel'

# Provides an empty in-memory DB and helpers for unit testing
# Import this file instead of db.rb into your spec files
DB = Sequel.sqlite

DB.create_table(:m_users) do
  primary_key :id, auto_increment: true
  Integer :user_type, null: false
  String :email, null: false
  String :password, null: false
  String :description
  String :explanation
  String :request
  Integer :acceptance
  Integer :suspension
  String :field
end

DB.create_table(:admins) do
  String :login, null: false
  String :password, null: false
end

