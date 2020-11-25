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

pain = Category.create!(name: "Vin")
pain.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/vins.png')),
  filename: 'vins.png'
)

boucherie = Category.create!(name: "Viande")
boucherie.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/viande.png')),
  filename: 'viande.png'
)

poisson = Category.create!(name: "Poisson")
poisson.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/poissons.png')),
  filename: 'poisson.png'
)

laitier = Category.create!(name: "Laitier")
laitier.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/laitiers.png')),
  filename: 'laitiers.png'
)

fruit = Category.create!(name: "Fruit")
fruit.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/fruits.png')),
  filename: 'fruits.png'
)

boulangerie = Category.create!(name: "Boulangerie")
boulangerie.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/boulangerie.png')),
  filename: 'boulangerie.png'
)

oeuf = Category.create!(name: "Oeuf")
oeuf.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/oeufs.png')),
  filename: 'oeufs.png'
)

cereale = Category.create!(name: "Céréale")
cereale.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/cereales.png')),
  filename: 'cereales.png'
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


henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['bio'], address: 'Nantes', opening_time: '8h-17h', description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm.png'
)
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm1.png'
)
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm2.png'
)
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)


file2 = File.open(Rails.root.join('db/fixtures/farms/farm1.png'))
meleze = Farm.create!(name: "La ferme du Mélèze", user: user1, labels: ['bio'], address: 'Pornichet', opening_time: '8h-17h')
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')

file3 = URI.open(Rails.root.join('db/fixtures/farms/farm2.png'))
jonas = Farm.create!(name: "La Ferme de Jonas", user: user2, labels: ['bio'], address: 'Clavan', opening_time: '8h-17h')
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')

file4 = URI.open(Rails.root.join('db/fixtures/farms/farm3.png'))
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user2, labels: ['bio'], address: 'Paris', opening_time: '8h-17h')
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')

file5 = URI.open(Rails.root.join('db/fixtures/farms/farm1.png'))
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user2, labels: ['bio'], address: 'Toulouse', opening_time: '8h-17h')
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
