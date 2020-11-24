# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

User.destroy_all
Farm.destroy_all

user1 = User.create!(
  email: "test@exemp.com",
  password: "password",
  name: "henry")
user1.photo.attach(io: File.open('app/assets/images/seed/user1.png'), filename: 'seed-henry.png')

user2 = User.create!(
  email: "test@exemple.com",
  password: "password",
  name: "jonas")
user2.photo.attach(io: File.open('app/assets/images/seed/user2.png'), filename: 'seed-henry.png')


henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['bio'], sells: 19, address: 'Nantes', opening_time: '8h-17h')
henry.photos.attach(io: File.open('app/assets/images/seed/farm3.png'), filename: 'seed-henry.png')


file2 = File.open('app/assets/images/seed/farm1.png')
meleze = Farm.create!(name: "La ferme du Mélèze", user: user1, labels: ['bio'], sells: 18, address: 'Pornichet', opening_time: '8h-17h')
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')

file3 = URI.open('app/assets/images/seed/farm2.png')
jonas = Farm.create!(name: "La Ferme de Jonas", user: user2, labels: ['bio'], sells: 38, address: 'Clavan', opening_time: '8h-17h')
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')

file4 = URI.open('app/assets/images/seed/farm3.png')
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user2, labels: ['bio'], sells: 28, address: 'Paris', opening_time: '8h-17h')
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')

file5 = URI.open('app/assets/images/seed/farm1.png')
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user2, labels: ['bio'], sells: 12, address: 'Toulouse', opening_time: '8h-17h')
gallien.photos.attach(io: file5, filename: 'nes.png', content_type: 'image/png')
