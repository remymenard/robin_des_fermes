# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require 'date'

FarmCategory.destroy_all # they belong to a category, so let's destroy them first
Product.destroy_all
Category.destroy_all
OpeningHour.destroy_all
Farm.destroy_all # they belong to a user, so let's destroy them first
User.destroy_all

pain = Category.create!(name: "Vin")
pain.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/vins.png')),
  filename: 'vins.png'
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

viande = Category.create!(name: "Viande")
viande.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/viande.png')),
  filename: 'viande.png'
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

divers = Category.create!(name: "Produit de la ferme")
divers.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/divers.png')),
  filename: 'divers.png'
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


henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['bio'],
  address: 'Bahnhofstrasse 4/8, 8001 Zurich', opening_time: '8h-17h',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['8008', '8001', '1200'], accepts_take_away: true)
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
meleze = Farm.create!(name: "La ferme du Mélèze", user: user1, labels: ['bio'],
  address: 'Gerechtigkeitsgasse 10, 3011 Berne', opening_time: '8h-17h',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['1200', '1240', '1215'], accepts_take_away: false)
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')

file3 = File.open(Rails.root.join('db/fixtures/farms/farm2.png'))
jonas = Farm.create!(name: "La Ferme de Jonas", user: user2, labels: ['bio'],
  address: 'Bahnhofstrasse 67, 5000 Aarau ', opening_time: '8h-17h',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['5000', '5004', '5001'])
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')

file4 = File.open(Rails.root.join('db/fixtures/farms/farm3.png'))
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user2, labels: ['bio'],
  address: 'Rue de Carouge 22, 1205 Genève', opening_time: '8h-17h',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['1200', '1209', '1205'])
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')

file5 = File.open(Rails.root.join('db/fixtures/farms/farm1.png'))
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user2, labels: ['bio'],
  address: 'Zollikerstrasse 788, 8008 Zurich', opening_time: '8h-17h',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['8008', '8001', '8005'])
gallien.photos.attach(io: file5, filename: 'nes.png', content_type: 'image/png')


FarmCategory.create!(category: viande,  farm: henry)
FarmCategory.create!(category: divers,  farm: henry)
#FarmCategory.create!(category: poisson,  farm: henry)
#FarmCategory.create!(category: laitier,  farm: henry)
#FarmCategory.create!(category: fruit,  farm: henry)
#FarmCategory.create!(category: boulangerie,  farm: henry)
#FarmCategory.create!(category: oeuf,  farm: henry)
#FarmCategory.create!(category: cereale,  farm: henry)
FarmCategory.create!(category: pain,  farm: jonas)

meat = Product.create!(farm: henry, category: viande, name: "Meat", unit_price: 5, kg_price: 10, unit: "La pièce" )
meat.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat.png')),
  filename: 'meat.png'
)

meat1 = Product.create!(farm: henry, category: viande, name: "Meat1", unit_price: 52, kg_price: 100, unit: "La pièce" )
meat1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat1.png')),
  filename: 'meat1.png'
)

chicken = Product.create!(farm: henry, category: viande, name: "Chicken", unit_price: 25, kg_price: 120, unit: "La pièce" )
chicken.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/chicken.png')),
  filename: 'chicken.png'
)

juice = Product.create!(farm: henry, category: divers, name: "Jus de pomme", unit_price: 5, kg_price: 10, unit: "La pièce" )
juice.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple-juice.png')),
  filename: 'apple-juice.png'
)

honey = Product.create!(farm: henry, category: divers, name: "Honey", unit_price: 35, kg_price: 132, unit: "La pièce" )
honey.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/honey.png')),
  filename: 'honey.png'
)

oil = Product.create!(farm: henry, category: divers, name: "Oil", unit_price: 5, kg_price: 10, unit: "La pièce" )
oil.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/oil.png')),
  filename: 'oil.png'
)

potato = Product.create!(farm: henry, category: divers, name: "Potato", unit_price: 5, kg_price: 10, unit: "La pièce" )
potato.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/potato.png')),
  filename: 'potato.png'
)

egg = Product.create!(farm: henry, category: divers, name: "Egg", unit_price: 5, kg_price: 10, unit: "La pièce" )
egg.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

apple = Product.create!(farm: henry, category: divers, name:"Apple", unit_price: 5, kg_price: 10, unit: "La pièce" )
apple.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

lundi = OpeningHour.create!(farm: henry, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: henry, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: henry, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: henry, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: henry, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
