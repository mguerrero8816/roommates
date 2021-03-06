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

apartment_01 = Apartment.create(name: 'Old Place', address: '12345 This Street')
apartment_01.users << mike
apartment_01.users << jennice
apartment_01.users << yuki
apartment_01.users << danny

apartment_02 = Apartment.create(name: 'New Place', address: '67890 Up Road')
apartment_02.users << mike
apartment_02.users << jennice
apartment_02.users << yuki

Apartment.create(name: 'Goose Canyon', address: '9515 Goose Avenue')
Apartment.create(name: 'Chicken Valley', address: '11102 Chicken Road')
Apartment.create(name: 'Zapdos Apartments', address: '11395 Zapdos Avenue')
Apartment.create(name: 'Chuck E', address: '9494 Cheese Street')

bill_01 = Bill.create(name: 'Rent', cents: 220000, apartment_id: apartment_01.id, user_id: yuki.id, due: Time.now + 10.days)
bill_02 = Bill.create(name: 'Electric', cents: 10062, apartment_id: apartment_01.id, user_id: mike.id, due: Time.now + 10.days)
bill_03 = Bill.create(name: 'Water', cents: 16014, apartment_id: apartment_01.id, user_id: mike.id, due: Time.now + 10.days)
bill_04 = Bill.create(name: 'Internet', cents: 8000, apartment_id: apartment_01.id, user_id: jennice.id, due: Time.now + 10.days)
bill_05 = Bill.create(name: 'Rent', cents: 250000, apartment_id: apartment_02.id, user_id: jennice.id, due: Time.now + 10.days)
bill_06 = Bill.create(name: 'Water', cents: 9500, apartment_id: apartment_02.id, user_id: jennice.id, due: Time.now + 10.days)

payment_01 = Payment.create(payable_id: bill_01.id, payable_type: 'Debt', cents: 220000, paid: Time.new(2016, 1, 1))
payment_02 = Payment.create(payable_id: bill_02.id, payable_type: 'Debt', cents: 10000, paid: Time.new(2016, 2, 1))
payment_03 = Payment.create(payable_id: bill_02.id, payable_type: 'Debt', cents: 62, paid: Time.new(2016, 3, 1))
payment_04 = Payment.create(payable_id: bill_06.id, payable_type: 'Debt', cents: 9500, paid: Time.new(2016, 3, 1))

admin_role = Role.create( name: 'admin' )
admin.roles << admin_role

dev_role = Role.create( name: 'dev' )
mike.roles << dev_role

owner_role = Role.create( name: 'owner' )
