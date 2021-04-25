require 'require_all'
require_relative 'db'
require_all '../models'

# This file can be used to write departments and interests tables in DB.
# Tables must be existing in the database. Their previous data will be wiped
# Text files must list entries one per line.

# Data for departments and subjects was taken from university's website and filtered automatically and manually
departments = IO.readlines('departments.txt')
interests = IO.readlines('subjects.txt')

Department.unrestrict_primary_key
Interest.unrestrict_primary_key

Department.dataset.delete
Interest.dataset.delete

DB.transaction do
  departments.each do |d|
    Department.find_or_create(department: d.strip)
  end
end

DB.transaction do
  interests.each do |i|
    Interest.find_or_create(interest: i.strip)
  end
end

Department.restrict_primary_key
Interest.restrict_primary_key
