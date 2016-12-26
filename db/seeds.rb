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

test_payment = Payment.create(user_id: mike.id)
test_payment.splitters << mike
test_payment.splitters << jennice

test_apartment = Apartment.create(name: 'Test Place')
test_apartment.tenants << mike
test_apartment.tenants << jennice
