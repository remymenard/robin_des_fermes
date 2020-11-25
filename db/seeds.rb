# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

FarmCategory.destroy_all
Category.destroy_all
Farm.destroy_all
User.destroy_all

pain = Category.create!(name: "Boulangerie")
pain.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/cereales.png')),
  filename: 'cereales.png'
)

boucherie = Category.create!(name: "Viande")
boucherie.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/viande.png')),
  filename: 'viande.png'
)

poisson = Category.create!(name: "Poisson")
poisson.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/poissons.png')),
  filename: 'poissons.png'
)


user1 = User.create!(
  email: "test@exemp.com",
  password: "password",
  name: "henry")
user1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/users/user1.png')),
  filename: 'seed-henry.png'
)

user2 = User.create!(
  email: "test@exemple.com",
  password: "password",
  name: "jonas"
)
user2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/users/user2.png')),
  filename: 'seed-henry.png'
)


henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['bio'], sells: 19, address: 'Nantes', opening_time: '8h-17h')
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'seed-henry.png'
)


file2 = File.open(Rails.root.join('db/fixtures/farms/farm1.png'))
meleze = Farm.create!(name: "La ferme du Mélèze", user: user1, labels: ['bio'], sells: 18, address: 'Pornichet', opening_time: '8h-17h')
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')

file3 = URI.open(Rails.root.join('db/fixtures/farms/farm2.png'))
jonas = Farm.create!(name: "La Ferme de Jonas", user: user2, labels: ['bio'], sells: 38, address: 'Clavan', opening_time: '8h-17h')
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')

file4 = URI.open(Rails.root.join('db/fixtures/farms/farm3.png'))
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user2, labels: ['bio'], sells: 28, address: 'Paris', opening_time: '8h-17h')
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')

file5 = URI.open(Rails.root.join('db/fixtures/farms/farm1.png'))
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user2, labels: ['bio'], sells: 12, address: 'Toulouse', opening_time: '8h-17h')
gallien.photos.attach(io: file5, filename: 'nes.png', content_type: 'image/png')

FarmCategory.create!(category: pain,  farm: henry)
FarmCategory.create!(category: boucherie,  farm: henry)
FarmCategory.create!(category: pain,  farm: jonas)


