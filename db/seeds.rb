# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
%w(A+ B+ O+ O-).each{|r| Blood.create(:name => r) }

a = Person.new name: Faker::Name.first_name, surname: Faker::Name.last_name

p "=============="
p a
p "=============="