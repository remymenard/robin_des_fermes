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
Category.destroy_all
FarmCategory.destroy_all

pain = Category.create!(name: "Boulangerie")
boucherie = Category.create!(name: "Viande")
poisson = Category.create!(name: "Poisson")
laitier = Category.create!(name: "Laitier")
fruit = Category.create!(name: "Fruit")
boulangerie = Category.create!(name: "Boulangerie")
oeuf = Category.create!(name: "Oeuf")
cereale = Category.create!(name: "Céréale")


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


henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['bio'], sells: 19, address: 'Nantes', opening_time: '8h-17h', description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
henry.photos.attach(io: File.open('app/assets/images/seed/farm1.png'), filename: 'seed-henry.png')
henry.photos.attach(io: File.open('app/assets/images/seed/farm2.png'), filename: 'seed-henry.png')
henry.photos.attach(io: File.open('app/assets/images/seed/farm3.png'), filename: 'seed-henry.png')
henry.photos.attach(io: File.open('app/assets/images/seed/farm1.png'), filename: 'seed-henry.png')
henry.photos.attach(io: File.open('app/assets/images/seed/farm2.png'), filename: 'seed-henry.png')


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

FarmCategory.create!(category: pain,  farm: henry)
FarmCategory.create!(category: boucherie,  farm: henry)
FarmCategory.create!(category: poisson,  farm: henry)
FarmCategory.create!(category: laitier,  farm: henry)
FarmCategory.create!(category: fruit,  farm: henry)
FarmCategory.create!(category: boulangerie,  farm: henry)
FarmCategory.create!(category: oeuf,  farm: henry)
FarmCategory.create!(category: cereale,  farm: henry)
FarmCategory.create!(category: pain,  farm: jonas)


