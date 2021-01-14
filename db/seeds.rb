# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require 'date'


puts "Clean DB"
FarmCategory.destroy_all # they belong to a category, so let's destroy them first
Product.destroy_all
Category.destroy_all
OpeningHour.destroy_all
Farm.destroy_all # they belong to a user, so let's destroy them first
Order.destroy_all
User.destroy_all


puts "Create categories"
pain = Category.create!(name: "Boulangerie")
pain.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/vins.png')),
  filename: 'boulangerie.png'
)

boucherie = Category.create!(name: "Viande & Volaille")
boucherie.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/viande.png')),
  filename: 'viande.png'
)

poisson = Category.create!(name: "Poisson")
poisson.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/poissons.png')),
  filename: 'poisson.png'
)

laitier = Category.create!(name: "Produits laitiers")
laitier.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/laitiers.png')),
  filename: 'laitiers.png'
)

fruit = Category.create!(name: "Fruits & Légumes")
fruit.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/fruits.png')),
  filename: 'fruits.png'
)

huile = Category.create!(name: "Huile & Vinaigre")
huile.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/viande.png')),
  filename: 'huile.png'
)

vin = Category.create!(name: "Vins")
vin.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/boulangerie.png')),
  filename: 'vins.png'
)

oeuf = Category.create!(name: "Oeuf")
oeuf.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/oeufs.png')),
  filename: 'oeufs.png'
)

cereale = Category.create!(name: "Céréales-Farines")
cereale.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/cereales.png')),
  filename: 'cereales.png'
)

divers = Category.create!(name: "Divers")
divers.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/divers.png')),
  filename: 'divers.png'
)


user1 = User.create!(
  email: "postmaster@gra.app",
  password: "password",
  first_name: "henry",
  last_name: "Boucher",
  address_line_1: "6 boulevard adolphe",
  city: "nantes",
  zip_code: "1200",
  title: "M",
  admin: true,
)

user1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/users/user1.png')),
  filename: 'seed-henry.png'
)

puts "creation des fermes"

henry = Farm.create!(name: "Famille Henry", user: user1, labels: ['Bio-Suisse'],
  address: 'Bahnhofstrasse 4/8, 8001 Zurich',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['8008', '8001', '8005'], accepts_take_away: true,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h")
henry.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
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


file2 = File.open(Rails.root.join('db/fixtures/farms/farm2.png'))
meleze = Farm.create!(name: "La ferme du Mélèze", user: user1, labels: ['Bio-Suisse'],
  address: 'Gerechtigkeitsgasse 10, 3011 Berne',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['1200', '1240', '1215'], accepts_take_away: false,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h")
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm1.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm2.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)

file3 = File.open(Rails.root.join('db/fixtures/farms/farm3.png'))
jonas = Farm.create!(name: "La Ferme de Jonas", user: user1, labels: ['Bio-Suisse'],
  address: 'Bahnhofstrasse 67, 5000 Aarau ',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['5000', '5004', '5001'], accepts_take_away: false,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h")
jonas.photos.attach(io: file3, filename: 'nes.png', content_type: 'image/png')
jonas.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm1.png'
)
jonas.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm2.png'
)
jonas.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
jonas.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)

file4 = File.open(Rails.root.join('db/fixtures/farms/farm1.png'))
cave = Farm.create!(name: "La Cave de l'Abbatiale", user: user1, labels: ['Bio-Suisse'],
  address: 'Rue de Carouge 22, 1205 Genève',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['1200', '1209', '1205'], accepts_take_away: false,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h")
cave.photos.attach(io: file4, filename: 'nes.png', content_type: 'image/png')
cave.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm1.png'
)
cave.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm2.png'
)
cave.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
cave.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)

file5 = File.open(Rails.root.join('db/fixtures/farms/farm2.png'))
gallien = Farm.create!(name: "Le Domaine du Gallien", user: user1, labels: ['Bio-Suisse'],
  address: 'Zollikerstrasse 788, 8008 Zurich',
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations. La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.",
  regions: ['8008', '8001', '8005'], accepts_take_away: false,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h")
gallien.photos.attach(io: file5, filename: 'nes.png', content_type: 'image/png')
gallien.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm1.png'
)
gallien.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm2.png'
)
gallien.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
gallien.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)


puts "Create farm categories"
FarmCategory.create!(category_id: boucherie.id,  farm: henry)
FarmCategory.create!(category_id: divers.id,  farm: henry)
FarmCategory.create!(category_id: divers.id,  farm: gallien)
FarmCategory.create!(category_id: divers.id,  farm: jonas)
FarmCategory.create!(category_id: oeuf.id,  farm: jonas)
FarmCategory.create!(category_id: boucherie.id,  farm: meleze)
FarmCategory.create!(category_id: boucherie.id,  farm: gallien)
FarmCategory.create!(category_id: divers.id,  farm: cave)
FarmCategory.create!(category_id: divers.id,  farm: meleze)


puts "Create products"
meat = Product.create!(farm: henry, category: boucherie, name: "Meat",
  price_cents: 5, price_per_unit_cents: 10, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

meat.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat.png')),
  filename: 'meat.png'
)

oeuf = Product.create!(farm: jonas, category: oeuf, name: "Oeuf",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

oeuf.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

meat1 = Product.create!(farm: henry, category: boucherie, name: "steack",
  price_cents: 5200, price_per_unit_cents: 10000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

meat1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat1.png')),
  filename: 'meat1.png'
)

steack = Product.create!(farm: meleze, category: boucherie, name: "Steack",
  price_cents: 700, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Dégustez ce savoureux steak de boeuf.",
  ingredients: "boeuf",
  label: ['bio'],
  available: true
)

steack.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat1.png')),
  filename: 'meat1.png'
)

chicken = Product.create!(farm: henry, category: boucherie, name: "Poulet",
  price_cents: 2500, price_per_unit_cents: 12000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

chicken.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/chicken.png')),
  filename: 'chicken.png'
)

chicken2 = Product.create!(farm: gallien, category: boucherie, name: "Poulet",
  price_cents: 2500, price_per_unit_cents: 12000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio']
)

chicken2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/chicken.png')),
  filename: 'chicken.png'
)

juice = Product.create!(farm: henry, category: divers, name: "Jus de pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)
juice.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple-juice.png')),
  filename: 'apple-juice.png'
)

apple_juice = Product.create!(farm: cave, category: divers, name: "Jus de pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)
apple_juice.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple-juice.png')),
  filename: 'apple-juice.png'
)

honey = Product.create!(farm: henry, category: divers, name: "Miel",
  price_cents: 3500, price_per_unit_cents: 13200, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

honey.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/honey.png')),
  filename: 'honey.png'
)

jam = Product.create!(farm: jonas, category: divers, name: "confiture",
  price_cents: 3500, price_per_unit_cents: 13200, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

jam.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/honey.png')),
  filename: 'honey.png'
)

oil = Product.create!(farm: henry, category: divers, name: "Oil",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

oil.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/oil.png')),
  filename: 'oil.png'
)

vinegar = Product.create!(farm: meleze, category: divers, name: "Vinaigre",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

vinegar.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/oil.png')),
  filename: 'oil.png'
)

potato = Product.create!(farm: henry, category: divers, name: "Patate",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

potato.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/potato.png')),
  filename: 'potato.png'
)

chips = Product.create!(farm: cave, category: divers, name: "Potato",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

chips.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/potato.png')),
  filename: 'potato.png'
)

egg = Product.create!(
  farm: henry, category: divers, name: "Oeuf", price_cents: 500, price_per_unit_cents: 1000,
  unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

egg.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

egg2 = Product.create!(
  farm: jonas, category: divers, name: "Oeuf", price_cents: 500, price_per_unit_cents: 1000,
  unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

egg2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

apple = Product.create!(farm: henry, category: divers, name:"Pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  available: true
)

apple.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)


apple2 = Product.create!(farm: jonas, category: divers, name:"Pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  fresh: false,
  available: true,
)

apple2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

apple3 = Product.create!(farm: jonas, category: divers, name:"Apple bio",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['bio'],
  fresh: true,
  available: true,
)
apple3.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

lundi = OpeningHour.create!(farm: henry, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: henry, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: henry, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: henry, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: henry, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))

lundi = OpeningHour.create!(farm: meleze, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: meleze, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: meleze, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: meleze, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: meleze, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))

lundi = OpeningHour.create!(farm: gallien, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: gallien, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: gallien, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: gallien, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: gallien, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))

lundi = OpeningHour.create!(farm: jonas, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: jonas, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: jonas, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: jonas, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: jonas, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))

lundi = OpeningHour.create!(farm: cave, day: 0, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mardi = OpeningHour.create!(farm: cave, day: 1, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
mercredi = OpeningHour.create!(farm: cave, day: 2, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
jeudi = OpeningHour.create!(farm: cave, day: 3, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
vendredi = OpeningHour.create!(farm: cave, day: 4, opens: DateTime.new(2012, 8, 29, 8, 35, 0), closes: DateTime.new(2012, 8, 29, 22, 35, 0))
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?