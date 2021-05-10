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
    Integer :suspension, default: 0
  end
  DB.create_table(:connections) do
    primary_key :id, auto_increment: true
    Integer :mentee_id, null: false
    Integer :mentor_id, null: false
    Integer :status, null: false
    Integer :active, null: false
    String :request_time
    String :end_time
    String :rejection_reason
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
  DB.drop_table(:connections)
  DB.drop_table(:departments)
  DB.drop_table(:interests)
  populate_tables
end


