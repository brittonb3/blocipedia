# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do
 Wiki.create!(
  title: Faker::Lorem.characters(10),
  body: Faker::Lorem.sentences(3)
 )
 end
 wikis = Wiki.all

 10.times do
   User.create!(
   email: Faker::Internet.email,
   password: Faker::Internet.password(8),
   role: 'standard'
   )
 end
 users = User.all


 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"
