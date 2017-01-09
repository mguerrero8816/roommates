# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: 'admin@admin.com', password: 'Abcd1234')
mike = User.create(email: 'mike@test.com', password: 'Abcd1234')
jennice = User.create(email: 'jennice@test.com', password: 'Abcd1234')
yuki = User.create(email: 'yuki@test.com', password: 'Abcd1234')
danny = User.create(email: 'danny@test.com', password: 'Abcd1234')

payment_01 = Payment.create(user_id: mike.id)
payment_01.splitters << mike
payment_01.splitters << jennice

apartment_01 = Apartment.create(name: 'Old Place')
apartment_01.tenants << mike
apartment_01.tenants << jennice
apartment_01.tenants << yuki
apartment_01.tenants << danny

apartment_02 = Apartment.create(name: 'New Place')
apartment_02.tenants << mike
apartment_02.tenants << jennice

bill_01 = Bill.create(name: 'Rent', cents: 220000, apartment_id: apartment_01.id, user_id: yuki.id)
bill_02 = Bill.create(name: 'Electric', cents: 10000, apartment_id: apartment_01.id, user_id: mike.id)
bill_03 = Bill.create(name: 'Water', cents: 16000, apartment_id: apartment_01.id, user_id: mike.id)
bill_04 = Bill.create(name: 'Internet', cents: 8000, apartment_id: apartment_01.id, user_id: jennice.id)
