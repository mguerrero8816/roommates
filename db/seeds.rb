# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: 'admin@admin.com', password: 'Abcd1234', first_name: 'Admin', last_name: 'User')
mike = User.create(email: 'mike@test.com', password: 'Abcd1234', first_name: 'Mike', last_name: 'Gtest')
jennice = User.create(email: 'jennice@test.com', password: 'Abcd1234', first_name: 'Jennice', last_name: 'Ltest')
yuki = User.create(email: 'yuki@test.com', password: 'Abcd1234', first_name: 'Yuki', last_name: 'Htest')
danny = User.create(email: 'danny@test.com', password: 'Abcd1234', first_name: 'Danny', last_name: 'Mtest')

apartment_01 = Apartment.create(name: 'Old Place')
apartment_01.tenants << mike
apartment_01.tenants << jennice
apartment_01.tenants << yuki
apartment_01.tenants << danny

apartment_02 = Apartment.create(name: 'New Place')
apartment_02.tenants << mike
apartment_02.tenants << jennice

bill_01 = Bill.create(name: 'Rent', cents: 220000, apartment_id: apartment_01.id, user_id: yuki.id, due: Time.now + 10.days)
bill_02 = Bill.create(name: 'Electric', cents: 10062, apartment_id: apartment_01.id, user_id: mike.id, due: Time.now + 10.days)
bill_03 = Bill.create(name: 'Water', cents: 16014, apartment_id: apartment_01.id, user_id: mike.id, due: Time.now + 10.days)
bill_04 = Bill.create(name: 'Internet', cents: 8000, apartment_id: apartment_01.id, user_id: jennice.id, due: Time.now + 10.days)
