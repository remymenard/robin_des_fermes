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

user = User.create!(
  email: "test@exemp.com",
  password: "password")

henry = Farm.create!(name: "Famille Henry", user: user)
henry.photos.attach(io: File.open('app/assets/images/seed/seed-meleze.png'), filename: 'seed-henry.png')


file2 = File.open('app/assets/images/seed/seed-henry.png')
meleze = Farm.create!(name: "La ferme du Mélèze", user: user)
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')

file3 = URI.open('app/assets/images/seed/seed-henry.png')
jonas = Farm.create!(name: "La Ferme de Jonas", user: user)
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')

file4 = URI.open('app/assets/images/seed/seed-henry.png')
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user)
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')

file5 = URI.open('app/assets/images/seed/seed-henry.png')
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user)
gallien.photos.attach(io: file5, filename: 'nes.png', content_type: 'image/png')
