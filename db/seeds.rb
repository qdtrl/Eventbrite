# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

p " ********************************* "
p " *                               * "
p " *         BEGIN OF SEED         * "
p " *                               * "
p " ********************************* "

p "Destroy curent data..."

p "Destroying User... #{User.count} "
User.destroy_all
p "Destroying Event... #{Event.count} "
Event.destroy_all
p "-----------------------"
p "-----------------------"

# USERS
name = []
5.times do |n|
  name = Faker::TvShows::Suits.character.split(" ")
  User.create!(
    first_name: name[0],
    last_name: name[1],
    description: Faker::TvShows::Suits.quote,
    email: "suits_user#{n}@yopmail.com",
    password: "password#{n += 1}"
  )
end
puts "#{tp User.all}"
p "Creation Users... #{User.count}"
puts "DONE"
p "-----------------------"
p "-----------------------"

# EVENTS
5.times do
  Event.create!(
    start_date: DateTime.now + 60,
    title: Faker::Movie.title,
    duration: [15, 30, 35, 40, 45, 50, 55, 60].sample,
    description: Faker::Movies::StarWars.quote,
    price: Faker::Number.between(from: 15, to: 99),
    location: Faker::Address.city,
    event_admin: User.all.sample
  )
end
puts "#{tp Event.all}"
p "Creation Events... #{Event.count}"
puts "DONE"
p "-----------------------"
p "-----------------------"

p " ********************************* "
p " *                               * "
p " *          END OF SEED          * "
p " *                               * "
p " ********************************* "

