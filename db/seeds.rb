# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Listing.all.each do |listing|
#   listing.destroy
# end

Reservation.all.each do |reservation|
  reservation.destroy
end 

# User.all.each do |user|
#   user.update(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: "#{Faker::ElderScrolls.first_name}#{Faker::ElderScrolls.first_name}")
# end

# User.all.each do |user|
#   if user.id == 2
#     user.update(role: "superadmin")
#   elsif user.id == 3
#     user.update(role: "moderator")
#   else
#     user.update(role: "customer")
#   end
# end
#
# # Seed Users
# user = {}
# user['encrypted_password'] = 'asdf'
# user['salt'] = 'salty'
#
# ActiveRecord::Base.transaction do
#   20.times do
#     user['username'] = "#{Faker::ElderScrolls.first_name}#{Faker::ElderScrolls.first_name}"
#     user['first_name'] = Faker::Name.first_name
#     user['last_name'] = Faker::Name.last_name
#     user['email'] = Faker::Internet.email
#
#     User.create(user)
#   end
# end

# Seed Listings
# listing = {}
# uids = []
# User.all.each { |u| uids << u.id }
#
# ActiveRecord::Base.transaction do
#   40.times do
#     listing['bedrooms'] = rand(1..6)
#     listing['max_guests'] = rand(1..10)
#     listing['baths'] = rand(1..4)
#
#     country = Faker::Address.country
#     state = Faker::Address.state
#     city = Faker::Address.city
#     zipcode = Faker::Address.zip_code
#     listing['address'] = "#{Faker::Address.street_address}, #{city}, #{state}, #{zipcode}, #{country}"
#
#     listing['rate_in_usd'] = rand(80..500)
#     listing['amenities'] = Faker::Hipster.sentence
#
#     listing['user_id'] = uids.sample
#
#     Listing.create(listing)
#   end
# end
