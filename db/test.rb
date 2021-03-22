require 'sequel'

# Creates user and admin tables
def populate_tables
  DB.create_table(:users) do
    primary_key :id, auto_increment: true
    Integer :user_type, null: false
    String :email, null: false
    String :password, null: false
    String :name
    String :department
    String :bio
    String :interest_areas
    String :request
    Integer :acceptance
    Integer :suspension
  end

  DB.create_table(:admins) do
    String :login, null: false
    String :password, null: false
  end
end

def cleanup
  DB.drop_table(:users)
  DB.drop_table(:admins)
  populate_tables
end


