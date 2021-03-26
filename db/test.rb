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
  DB.create_table(:departments) do
    primary_key :id, auto_increment: true
    String :department
  end
  DB.create_table(:interests) do
    primary_key :id, auto_increment: true
    String :interest
  end
end

def cleanup
  DB.drop_table(:users)
  DB.drop_table(:admins)
  DB.drop_table(:departments)
  DB.drop_table(:interests)
  populate_tables
end


