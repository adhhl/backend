# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!([
               {email: "huynh@gmail.com", password: "123456", name: "betty2310", nickname: "betty2310"},
               {email: "pa@gmail.com", password: "123456", name: "Phuong anh", nickname: "pa"},
             ])
10.times do
  User.create!(email: Faker::Internet.email, password: "123456", name: Faker::Name.name, nickname: Faker::Name.female_first_name)
end

20.times do
  Deck.create!(name: Faker::Name.name, user_id: rand(1..10))
end

100.times do
  Card.create!(front: Faker::Lorem.sentence(word_count: 3), back: Faker::Lorem.sentence(word_count: 3),
               user_id: rand(1..10), deck_id: rand(1..20))
end

100.times do
  ReviewHistory.create!(card_id: rand(1..100), rating: rand(0..3))
end
