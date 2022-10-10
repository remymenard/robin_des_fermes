# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require "open-uri"
require 'date'


puts "Clean DB"
FarmCategory.destroy_all # they belong to a category, so let's destroy them first
OrderLineItem.destroy_all
FarmOrder.destroy_all
Product.destroy_all
Category.destroy_all
OpeningHour.destroy_all
FarmOrder.destroy_all
OrderLineItem.destroy_all
Farm.destroy_all # they belong to a user, so let's destroy them first
Order.destroy_all
User.destroy_all
Office.destroy_all
FarmOffice.destroy_all
Order.destroy_all
FarmOrder.destroy_all

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
  io: File.open(Rails.root.join('db/fixtures/categories/huile.png')),
  filename: 'huile.png'
)

vin = Category.create!(name: "Vins")
vin.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/categories/vins.png')),
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

user_henry = User.new(
  email: "remy@drakkr.com",
  password: "password",
  first_name: "Henry",
  last_name: "Boucher",
  address_line_1: "6 boulevard adolphe",
  city: "nantes",
  zip_code: "1200",
  title: "M",
  admin: false,
  number_phone: "06 44 63 71 11",
)

user_henry.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/users/user1.png')),
  filename: 'seed-henry.png'
)

user_henry.save!

user1 = User.new(
  email: "ivan@perroud.me",
  password: "password",
  first_name: "Ivan",
  last_name: "Perroud",
  address_line_1: "Chemin de Bonlieu 11",
  city: "Fribourg",
  zip_code: "1700",
  title: "M",
  admin: true,
  number_phone: "079 331 32 04",
)

user1.skip_confirmation!
user1.save!

user1 = User.last

user1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/users/user1.png')),
  filename: 'seed-henry.png'
)

puts "creation des fermes"

henry = Farm.new(name: "Famille Henry", user: user_henry, labels: ['Bio-Suisse'],
  address: 'Route du Village 62', delivery_delay: 2,
  minimum_order_price_cents: 4000,
  regions: ["1852", "1853", "1856", "1860", "1867", "1867", "1867"],
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations.",
  accepts_take_away: true, city: "Vulliens", zip_code: "1085", country: "france",
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h", active: true, long_description: "La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
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
henry.photo_portrait.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)
henry.farm_profil_picture.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)

henry.save

file2 = File.open(Rails.root.join('db/fixtures/farms/farm.png'))
meleze = Farm.new(name: "La ferme du Mélèze", user: user1, labels: ['Bio-Suisse'],
  address: 'Rte des Granges 4', city: "Ropraz", zip_code: "1088", delivery_delay: 2,
  minimum_order_price_cents: 1000,
  regions: ["1852", "1853", "1856", "1860", "1867", "1867", "1867"],
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations.",
  accepts_take_away: false, country: "france",
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h", active: true, long_description: "La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
meleze.photos.attach(io: file2, filename: 'nes.png', content_type: 'image/png')
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm1.png')),
  filename: 'farm1.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm2.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm3.png')),
  filename: 'farm3.png'
)
meleze.photos.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png')
meleze.photo_portrait.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png')
meleze.farm_profil_picture.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)

meleze.save!

file3 = File.open(Rails.root.join('db/fixtures/farms/farm3.png'))


jonas = Farm.new(name: "La Ferme de Jonas", user: user1, labels: ['Bio-Suisse'],
  regions: ["1852", "1853", "1856", "1860", "1867", "1867", "1867"],
  minimum_order_price_cents: 4000,
  address: 'Chemin de la Chapelle 3',  city: "Carrouge", zip_code: "1084", country: "france", delivery_delay: 2,
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations.",
  accepts_take_away: false,
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h", active: true, long_description: "La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
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
jonas.photo_portrait.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)
jonas.farm_profil_picture.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)

jonas.save!

file4 = File.open(Rails.root.join('db/fixtures/farms/farm1.png'))

cave = Farm.new(name: "La Cave de l'Abbatiale", user: user1, labels: ['Bio-Suisse'],
  address: 'Chemin de Montagny', city: "Aran", zip_code: "1091", delivery_delay: 2,
  minimum_order_price_cents: 2000,
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations.",
  accepts_take_away: false, country: "france",
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h", active: true, long_description: "La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
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
cave.photo_portrait.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)
cave.farm_profil_picture.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)

cave.save!

file5 = File.open(Rails.root.join('db/fixtures/farms/farm2.png'))
gallien = Farm.new(name: "Le Domaine du Gallien", user: user1, labels: ['Bio-Suisse'],
  address: 'Rte du village 15', city: "Carrouge", zip_code: "1084", delivery_delay: 2,
  minimum_order_price_cents: 4000,
  description: "Le domaine a été acquis en 1926 par Oscar Savary, originaire de Payerne. Nous sommes aujourd’hui la 4ème génération à exploiter le domaine qui s’est agrandit au cours des générations.",
  accepts_take_away: false, country: "france",
  opening_time: "Du mardi au samedi — 10h à 13h / 14h à 19h", active: true, long_description: "La production laitière était la principale source de revenus jusqu’en 2011 ou l’arrêt de cette production, prise à contre cœur, a été décidée en raison d’un prix du lait dérisoire payé au producteur. C’est alors qu’il a fallu révaluer les productions de la ferme. C’est pourquoi aujourd’hui la ferme s’est orientée vers la vente directe ainsi que la sensibilisation de l’agriculture d’aujourd’hui aux petits et grands n’ayant pas de liens directs avec le monde agricole.")
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
gallien.photo_portrait.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm2.png')),
  filename: 'farm4.png'
)
gallien.farm_profil_picture.attach(
  io: File.open(Rails.root.join('db/fixtures/farms/farm.png')),
  filename: 'farm4.png'
)

gallien.save!

Farm.update(delivery_delay: 3)

puts "Create farm categories"
FarmCategory.create!(category_id: vin.id,  farm: henry)
FarmCategory.create!(category_id: huile.id,  farm: henry)
FarmCategory.create!(category_id: divers.id,  farm: gallien)
FarmCategory.create!(category_id: divers.id,  farm: jonas)
FarmCategory.create!(category_id: oeuf.id,  farm: jonas)
FarmCategory.create!(category_id: boucherie.id,  farm: meleze)
FarmCategory.create!(category_id: boucherie.id,  farm: gallien)
FarmCategory.create!(category_id: divers.id,  farm: cave)
FarmCategory.create!(category_id: divers.id,  farm: meleze)


puts "Create products subcategories"
sub1 = ProductSubcategory.new(name: "subcategory 1", farm: henry)
sub1.save!
sub2 = ProductSubcategory.new(name: "subcategory 2", farm: henry)
sub2.save!

puts "Create products"
meat = Product.new(farm: henry, category: boucherie, name: "Meat",
  price_cents: 5, price_per_unit_cents: 10, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  product_subcategory: sub1,
  total_weight: "20",
)

meat.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat.png')),
  filename: 'meat.png'
)

meat.save!

oeuf = Product.new(farm: jonas, category: oeuf, name: "Oeuf",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  total_weight: "20",
)

oeuf.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

oeuf.save!

meat1 = Product.new(farm: henry, category: boucherie, name: "steack",
  price_cents: 5200, price_per_unit_cents: 10000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  product_subcategory: sub2,
  total_weight: "20",
)

meat1.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat1.png')),
  filename: 'meat1.png'
)

meat1.save!

steack = Product.new(farm: meleze, category: boucherie, name: "Steack",
  price_cents: 700, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Dégustez ce savoureux steak de boeuf.",
  ingredients: "boeuf",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  total_weight: "20",
)

steack.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/meat1.png')),
  filename: 'meat1.png'
)

steack.save!

chicken = Product.new(farm: henry, category: boucherie, name: "Poulet",
  price_cents: 2500, price_per_unit_cents: 12000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  product_subcategory: sub2,
  total_weight: "20",
)

chicken.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/chicken.png')),
  filename: 'chicken.png'
)

chicken.save!

chicken2 = Product.new(farm: gallien, category: boucherie, name: "Poulet",
  price_cents: 2500, price_per_unit_cents: 12000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  total_weight: "20",
)

chicken2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/chicken.png')),
  filename: 'chicken.png'
)

chicken2.save!

juice = Product.new(farm: henry, category: divers, name: "Jus de pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  product_subcategory: sub1,
  total_weight: "20",
)
juice.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple-juice.png')),
  filename: 'apple-juice.png'
)
juice.save!

apple_juice = Product.new(farm: cave, category: divers, name: "Jus de pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: true,
  total_weight: "20",
)
apple_juice.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple-juice.png')),
  filename: 'apple-juice.png'
)

apple_juice.save!

honey = Product.new(farm: henry, category: divers, name: "Miel",
  price_cents: 3500, price_per_unit_cents: 13200, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  product_subcategory: sub1,
  total_weight: "20",
)

honey.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/honey.png')),
  filename: 'honey.png'
)

honey.save!

jam = Product.new(farm: jonas, category: divers, name: "confiture",
  price_cents: 3500, price_per_unit_cents: 13200, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  total_weight: "20",
)

jam.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/honey.png')),
  filename: 'honey.png'
)

jam.save!

oil = Product.new(farm: henry, category: divers, name: "Oil",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  product_subcategory: sub2,
  total_weight: "20",
)

oil.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/oil.png')),
  filename: 'oil.png'
)

oil.save!

vinegar = Product.new(farm: meleze, category: divers, name: "Vinaigre",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  total_weight: "20",
)

vinegar.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/oil.png')),
  filename: 'oil.png'
)

vinegar.save!

potato = Product.new(farm: henry, category: divers, name: "Patate",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  product_subcategory: sub2,
  total_weight: "20",
)

potato.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/potato.png')),
  filename: 'potato.png'
)

potato.save!

chips = Product.new(farm: cave, category: divers, name: "Potato chips",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  total_weight: "25"
)

chips.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/potato.png')),
  filename: 'potato.png'
)

chips.save!

egg = Product.new(
  farm: henry, category: divers, name: "Oeuf", price_cents: 500, price_per_unit_cents: 1000,
  unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  product_subcategory: sub1,
  total_weight: "20",
)

egg.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

egg.save!

egg2 = Product.new(
  farm: jonas, category: divers, name: "Oeuf", price_cents: 500, price_per_unit_cents: 1000,
  unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  total_weight: "20",
)

egg2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/egg.png')),
  filename: 'egg.png'
)

egg2.save!

apple = Product.new(farm: henry, category: divers, name:"Pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  available: true,
  fresh: false,
  product_subcategory: sub2,
  total_weight: "20",
)

apple.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

apple.save!


apple2 = Product.new(farm: jonas, category: divers, name:"Pomme",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  fresh: false,
  available: true,
  total_weight: "20",
)

apple2.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

apple2.save!

apple3 = Product.new(farm: jonas, category: divers, name:"Apple bio",
  price_cents: 500, price_per_unit_cents: 1000, unit: "La pièce",
  description: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ingredients: "Xxxorem Ipsum is simply dummy text of the printing and typesetting industry.",
  label: ['Bio-Suisse'],
  fresh: true,
  available: true,
  total_weight: "20",
)
apple3.photo.attach(
  io: File.open(Rails.root.join('db/fixtures/products/apple.png')),
  filename: 'apple.png'
)

apple3.save!

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

first_order = Order.create(price_cents: 900, price_currency: "CHF", status: "waiting", buyer: user1)

first_farm_order = FarmOrder.create!(order: first_order, farm: henry, price_cents: 900, express_shipping: true  )

apple_order = OrderLineItem.create!(farm_order: first_farm_order, order: first_order, product: apple3, quantity: 1, total_price_cents: 300, total_price_currency: "CHF")
chips_order = OrderLineItem.create!(farm_order: first_farm_order,order: first_order, product: chips, quantity: 1, total_price_cents: 300, total_price_currency: "CHF")
egg_order = OrderLineItem.create!(farm_order: first_farm_order, order: first_order, product: egg, quantity: 1, total_price_cents: 300, total_price_currency: "CHF")

office1 = Office.create!(name: "Aigle Distribution", regions: [1852, 1853, 1856, 1860, 1867, 1867, 1867])
office2 = Office.create!(name: "Apples", regions: [1113, 1114, 1115, 1116, 1117, 1126, 1127, 1128, 1135, 1136, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1149])
office3 = Office.create!(name: "Aubonne", regions: [1165, 1170, 1174, 1174, 1175, 1176])
office4 = Office.create!(name: "Avenches Distribution", regions: [1564, 1580, 1580, 1580, 1583, 1584, 1585, 1585, 1585, 1586, 1587, 1587, 1588, 1589, 1595, 1595])
office5 = Office.create!(name: "Bercher", regions: [1038, 1044, 1045, 1046, 1047])
office6 = Office.create!(name: "Bernex Distribution", regions: [1232, 1233])
office7 = Office.create!(name: "Bevaix", regions: [2022, 2023, 2024, 2025, 2027, 2027, 2028])
office8 = Office.create!(name: "Bex Distribution", regions: [1880, 1880, 1880, 1880, 1880, 1882, 1884, 1884, 1884, 18857])
office8 = Office.create!(name: "Biel/Bienne Zustellung", regions: [2502, 2502, 2503, 2503, 2504, 2504, 2505, 2505, 2512, 2532, 2532, 2533, 2533, 2534, 2534, 2535, 2536, 2537, 2538, 2552, 2555, 2556, 2556, 2557, 2558, 2560, 2562, 2563, 2564, 2565, 2572, 2572])
office10 = Office.create!(name: "Blignou (Ayent", regions: [1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1971, 1971, 1972, 1974, 1977, 1978])
office11 = Office.create!(name: "Bulle 1 Distribution", regions: [1625, 1625, 1626, 1626, 1626, 1627, 1628, 1630, 1632, 1633, 1633, 1638, 1642, 1643, 1644, 1645, 1646])
office12 = Office.create!(name: "Bussigny Distribution", regions: [1029, 1030, 1031, 1034, 1035, 1036, 1302])
office13 = Office.create!(name: "Carouge GE Distribution", regions: [1227, 1227, 1234, 1255, 1256])
office14 = Office.create!(name: "Chailly-Montreux Distribution", regions: [1816, 1817, 1822, 1832, 1832, 1833, 1845, 1846])
office15 = Office.create!(name: "Champéry", regions: [1872, 1873, 1873, 1873, 1874, 1875])
office16 = Office.create!(name: "Château-d'Oex", regions: [1658, 1658, 1659, 1659, 1660, 1660, 1660, 1660])
office17 = Office.create!(name: "Châtel-St-Denis Distribution", regions: [1611, 1614, 1615, 1616, 1617, 1617, 1618, 1619, 1623, 1624, 1624, 1624])
office18 = Office.create!(name: "Chêne-Bourg Distribution", regions: [1224, 1225, 1226, 1231, 1241, 1243, 1251, 1252, 1254])
office19 = Office.create!(name: "Cheseaux-sur-Lausanne Distribution", regions: [1032, 1033, 1037, 1054])
office20 = Office.create!(name: "Chexbres Distribution", regions: [1070, 1071, 1071, 1071])
office21 = Office.create!(name: "Collombey", regions: [1868, 1893, 1895, 1896, 1896, 1897, 1897, 1898, 1899])
office22 = Office.create!(name: "Cologny Distribution", regions: [1223, 1253])
office23 = Office.create!(name: "Colombier NE Distribution", regions: [2012, 2013, 2014, 2019, 2019])
office24 = Office.create!(name: "Conthey Distribution", regions: [1955, 1955, 1955, 1955, 1955, 1955, 1957, 1962, 1963, 1964, 1975, 1976, 1976, 1976, 1994])
office25 = Office.create!(name: "Coppet Distribution", regions: [1291, 1295, 1295, 1296])
office26 = Office.create!(name: "Corcelles NE Distribution", regions: [2035, 2036, 2037, 2037])
office27 = Office.create!(name: "Corgémont", regions: [2603, 2604, 2605, 2606, 2607, 2608, 2608, 2612])
office28 = Office.create!(name: "Cortaillod", regions: [2015, 2016, 2017])
office29 = Office.create!(name: "Courgenay", regions: [2882, 2883, 2884, 2885, 2886, 2887, 2888, 2889, 2946, 2947, 2950, 2950, 2952, 2953, 2953, 2954])
office30 = Office.create!(name: "Courtepin", regions: [1721, 1721, 1721, 1721, 1783, 1783, 1783, 1783, 1784, 1784, 1784, 1785, 1791, 1791])
office31 = Office.create!(name: "Couvet", regions: [2103, 2105, 2108, 2112, 2113, 2114, 2115, 2116, 2117, 2123, 2124, 2126, 2127, 2149, 2149, 2149])
office32 = Office.create!(name: "Crissier 1 Distribution", regions: [1023, 1024])
office33 = Office.create!(name: "Delémont 1 Distribution", regions: [2800, 2802, 2803, 2805, 2806, 2807, 2807, 2812, 2813, 2814, 2822, 2823, 2824, 2825, 2826, 2827, 2827, 2828, 2829, 2830, 2830, 2832, 2842, 2843, 2852, 2853, 2854, 2855, 2856, 2857, 2863, 2864, 2873])
office34 = Office.create!(name: "Echallens Distribution", regions: [1040, 1040, 1040, 1041, 1041, 1041, 1041, 1041, 1041, 1042, 1042, 1042, 1043, 1375, 1376, 1376, 1376, 1377])
office35 = Office.create!(name: "Evolène", regions: [1968, 1969, 1969, 1969, 1969, 1969, 1982, 1983, 1983, 1984, 1984, 1985, 1985, 1985])
office36 = Office.create!(name: "Farvagny-le-Grand", regions: [1695, 1695, 1695, 1695, 1696, 1725, 1726, 1726, 1726, 1726, 1727, 1727, 1728, 1730, 1733])
office37 = Office.create!(name: "Fétigny", regions: [1468, 1470, 1470, 1470, 1470, 1473, 1473, 1474, 1475, 1475, 1475, 1482, 1483, 1483, 1483, 1484, 1484, 1485, 1486, 1489, 1523, 1524, 1525, 1525, 1527, 1528, 1528, 1529, 1530, 1532, 1533, 1534, 1534, 1535, 1536, 1537, 1538, 1541, 1541, 1541, 1542, 1543, 1544, 1545, 1551, 1552, 1553, 1554, 1554, 1555, 1562, 1563, 1565, 1565, 1566, 1566, 1567, 1568])
office38 = Office.create!(name: "Fontainemelon", regions: [2042, 2043, 2046, 2052, 2052, 2053, 2054, 2054, 2056, 2057, 2058, 2063, 2063, 2063, 2063, 2065, 2206, 2207, 2208])
office39 = Office.create!(name: "Forel (Lavaux", regions: [1072, 1073, 1073])
office40 = Office.create!(name: "Founex", regions: [1279, 1279, 1297, 1298, 1299])
office41 = Office.create!(name: "Fribourg 1 Distribution", regions: [1700, 1720, 1720, 1722, 1723, 1723, 1723, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1731, 1732, 1752, 1753, 1762, 1763, 1782, 1782, 1782, 1782, 1782, 1782])
office42 = Office.create!(name: "Froideville", regions: [1055, 1058])
office43 = Office.create!(name: "Fully Distribution", regions: [1906, 1913, 1926])
office44 = Office.create!(name: "Genève 15 Aéroport Dépôt", regions: [1215])
office45 = Office.create!(name: "Genève 2 Distribution", regions: [1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209])
office46 = Office.create!(name: "Gingins", regions: [1263, 1274, 1274, 1275, 1276, 1277, 1277, 1278])
office47 = Office.create!(name: "Gland Distribution", regions: [1182, 1183, 1184, 1184, 1187, 1188, 1188, 1189, 1195, 1195, 1196, 1261, 1261, 1261, 1264, 1265, 1267, 1267, 1268, 1268, 1269, 1272, 1273])
office48 = Office.create!(name: "Grand-Lancy 1 Distribution", regions: [1212, 1228, 1257, 1258])
office49 = Office.create!(name: "Grand-Saconnex Distribution", regions: [1216, 1218, 1292])
office50 = Office.create!(name: "Grenchen 1 Zustellung", regions: [2540, 2542, 2543, 2544, 2545, 2553, 2554])
office51 = Office.create!(name: "Gurmels", regions: [1792, 1792, 1793, 1794])
office52 = Office.create!(name: "Haute-Nendaz", regions: [1993, 1993, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1997, 1997, 1997])
office53 = Office.create!(name: "Hérémence", regions: [1981, 1987, 1988, 1988])
office54 = Office.create!(name: "La Chaux-de-Fonds 1 Distribution", regions: [2300, 2300, 2322, 2325, 2333, 2333])
office55 = Office.create!(name: "La Neuveville Distribution", regions: [2513, 2514, 2515, 2516, 2517, 2518, 2520, 2523, 2525])
office56 = Office.create!(name: "La Tour-de-Trême", regions: [1634, 1635, 1636, 1637, 1647, 1648, 1649, 1651, 1652, 1652, 1653, 1653, 1654, 1656, 1656, 1657, 1661, 1663, 1663, 1663, 1663, 1665, 1666, 1666, 1667, 1669, 1669, 1669, 1669, 1669])
office57 = Office.create!(name: "Lausanne 11 CHUV", regions: [1011])
office58 = Office.create!(name: "Lausanne Distribution", regions: [1000, 1000, 1000, 1003, 1004, 1005, 1006, 1007, 1008, 1008, 1009, 1010, 1012, 1015, 1018, 1066, 1068, 1092])
office59 = Office.create!(name: "Le Châble VS Distribution", regions: [1934, 1934, 1941, 1941, 1942, 1947, 1947, 1948, 1948, 1948])
office60 = Office.create!(name: "Le Lignon Distribution", regions: [1219, 1219, 1219])
office61 = Office.create!(name: "Le Locle Distribution", regions: [2314, 2316, 2316, 2318, 2400, 2400, 2405, 2406, 2406, 2406, 2406, 2414, 2416])
office62 = Office.create!(name: "Le Mont-sur-Lausanne Distribution", regions: [1052, 1053, 1053])
office63 = Office.create!(name: "Le Noirmont Distribution", regions: [2336, 2338, 2338, 2340, 2345, 2345, 2345, 2350, 2353, 2354, 2360, 2362, 2362, 2363, 2364])
office64 = Office.create!(name: "Le Sentier Distribution", regions: [1341, 1342, 1343, 1344, 1345, 1345, 1346, 1347, 1347, 1348])
office65 = Office.create!(name: "Leysin Distribution", regions: [1854, 1862, 1862, 1863, 1864, 1865, 1866])
office66 = Office.create!(name: "Leytron", regions: [1908, 1911, 1912, 1912, 1912, 1912, 1918])
office67 = Office.create!(name: "Lutry Distribution", regions: [1090, 1091, 1091, 1091, 1093, 1094, 1095, 1096, 1096, 1097, 1098])
office68 = Office.create!(name: "Marin-Epagnier Distribution", regions: [2068, 2072, 2073, 2074, 2075, 2075, 2087, 2088])
office69 = Office.create!(name: "Martigny 1 Distribution", regions: [1902, 1903, 1904, 1905, 1920, 1921, 1922, 1922, 1923, 1923, 1925, 1925, 1927, 1928, 1929, 1932, 1932])
office70 = Office.create!(name: "Meyrin Distribution", regions: [1217, 1242, 1281, 1283, 1283])
office71 = Office.create!(name: "Monthey 1 Distribution", regions: [1869, 1870, 1871, 1871, 1891])
office72 = Office.create!(name: "Montreux 1 Distribution", regions: [1815, 1820, 1820, 1820, 1823, 1824, 1844, 1847])
office73 = Office.create!(name: "Morges Distribution", regions: [1025, 1026, 1026, 1027, 1028, 1110, 1112, 1121, 1122, 1123, 1124, 1125, 1131, 1132, 1134, 1134])
office74 = Office.create!(name: "Moudon Distribution", regions: [1063, 1063, 1063, 1063, 1410, 1410, 1410, 1410, 1410, 1509, 1510, 1510, 1512, 1513, 1513, 1514, 1515, 1515, 1521, 1522, 1522, 1526, 1526])
office75 = Office.create!(name: "Moutier 1 Distribution", regions: [2740, 2742, 2743, 2744, 2745, 2746, 2747, 2747, 2748, 2748, 2762])
office76 = Office.create!(name: "Murten Zustellung", regions: [1795, 1796, 1797])
office77 = Office.create!(name: "Neuchâtel 2 Distribution", regions: [2000, 2034, 2067])
office78 = Office.create!(name: "Nyon 1 Distribution", regions: [1197, 1260, 1262, 1266, 1270, 1271])
office79 = Office.create!(name: "Orbe Distribution", regions: [1321, 1329, 1350, 1352, 1353, 1354, 1355, 1355, 1356, 1356, 1357, 1358, 1372, 1373, 1374])
office80 = Office.create!(name: "Orsières", regions: [1933, 1933, 1933, 1933, 1937, 1938, 1943, 1944, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1946])
office81 = Office.create!(name: "Palézieux Distribution", regions: [1076, 1077, 1078, 1080, 1083, 1084, 1085, 1607, 1607, 1607, 1607, 1608, 1608, 1608, 1608, 1610, 1610, 1610, 1612, 1613])
office82 = Office.create!(name: "Penthalaz Distribution", regions: [1303, 1304, 1304, 1304, 1304, 1305, 1306, 1307, 1308, 1312, 1313, 1315, 1316, 1317, 1318])
office83 = Office.create!(name: "Petit-Lancy Distribution", regions: [1213, 1213, 1236, 1237, 1284, 1285, 1286, 1287, 1288])
office84 = Office.create!(name: "Plaffeien", regions: [1716, 1716, 1716, 1719, 1719, 1737, 1738])
office85 = Office.create!(name: "Porrentruy 1 Distribution", regions: [2900, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2912, 2912, 2914, 2915, 2916, 2922, 2923, 2924, 2925, 2926, 2932, 2933, 2933, 2935, 2942, 2943, 2944])
office86 = Office.create!(name: "Prez-vers-Noréaz", regions: [1740, 1741, 1742, 1744, 1745, 1746, 1747, 1748, 1749, 1754, 1754, 1756, 1756, 1757, 1772, 1772, 1772, 1773, 1773, 1773, 1774, 1774, 1775, 1775, 1776])
office87 = Office.create!(name: "Reconvilier", regions: [2710, 2732, 2732, 2732, 2732, 2733, 2735, 2735, 2735, 2736, 2738])
office88 = Office.create!(name: "Renens VD 1 Distribution", regions: [1020, 1022])
office89 = Office.create!(name: "Rolle Distribution", regions: [1166, 1172, 1173, 1180, 1180, 1185, 1186])
office90 = Office.create!(name: "Romont FR Distribution", regions: [1609, 1609, 1609, 1670, 1670, 1670, 1673, 1673, 1673, 1673, 1673, 1674, 1674, 1674, 1675, 1675, 1675, 1676, 1677, 1678, 1679, 1680, 1680, 1681, 1681, 1682, 1682, 1682, 1682, 1682, 1683, 1683, 1683, 1684, 1685, 1686, 1686, 1687, 1687, 1687, 1688, 1688, 1689, 1690, 1690, 1691, 1692, 1694, 1694, 1694, 1694, 1697, 1697, 1699, 1699, 1699])
office91 = Office.create!(name: "Ropraz", regions: [1059, 1061, 1062, 1081, 1082, 1088])
office92 = Office.create!(name: "Savièse Distribution", regions: [1965])
office93 = Office.create!(name: "Saxon", regions: [1907, 1914, 1914])
office94 = Office.create!(name: "Sion 1 Distribution", regions: [1950, 1958, 1958, 1961, 1967, 1973, 1991, 1991, 1991, 1991, 1991, 1992, 1992, 1992, 1992])
office95 = Office.create!(name: "St-Imier Distribution", regions: [2610, 2610, 2610, 2610, 2613, 2615, 2615, 2616, 2616])
office96 = Office.create!(name: "St-Légier/Blonay Distribution", regions: [1806, 1807])
office97 = Office.create!(name: "St-Maurice", regions: [1890, 1890, 1892, 1892, 1892])
office98 = Office.create!(name: "St-Prex Distribution", regions: [1162, 1163, 1164, 1167, 1168, 1169])
office99 = Office.create!(name: "Sugiez", regions: [1786, 1787, 1787, 1787, 1788, 1789])
office100 = Office.create!(name: "Tafers", regions: [1712, 1713, 1714, 1715, 1717, 1718, 1734, 1735, 1736])
office101 = Office.create!(name: "Täuffelen", regions: [2575, 2575, 2575, 2576, 2577, 2577])
office102 = Office.create!(name: "Tramelan Distribution", regions: [2712, 2713, 2714, 2715, 2715, 2716, 2717, 2717, 2718, 2718, 2720, 2720, 2722, 2723])
office103 = Office.create!(name: "Vallorbe", regions: [1337, 1338])
office104 = Office.create!(name: "Vaulion", regions: [1322, 1323, 1324, 1325, 1326])
office105 = Office.create!(name: "Verbier", regions: [1936])
office106 = Office.create!(name: "Vernier Distribution", regions: [1214, 1220])
office107 = Office.create!(name: "Versoix Distribution", regions: [1239, 1290, 1290, 1293, 1294])
office108 = Office.create!(name: "Vésenaz Distribution", regions: [1222, 1244, 1245, 1246, 1247, 1248])
office109 = Office.create!(name: "Vevey 1 Distribution", regions: [1800, 1801, 1802, 1803, 1804, 1805, 1808, 1809, 1814])
office110 = Office.create!(name: "Vuiteboeuf", regions: [1416, 1417, 1417, 1418, 1420, 1421, 1421, 1423, 1423, 1423, 1423, 1424, 1425, 1426, 1426, 1427, 1428, 1428, 1429, 1430, 1431, 1431, 1432, 1432, 1433, 1434, 1435, 1436, 1436, 1437, 1438, 1439, 1441, 1442, 1443, 1443, 1443, 1445, 1446, 1450, 1450, 1450, 1452, 1453, 1453, 1454, 1454])
office111 = Office.create!(name: "Yverdon Distribution", regions: [1400, 1400, 1404, 1404, 1405, 1406, 1407, 1407, 1407, 1407, 1408, 1409, 1412, 1412, 1413, 1415, 1415, 1422, 1462, 1463, 1464, 1464])

farm_office1 = FarmOffice.create!(office: office1, farm: henry, delivery_day: 1, delivery_deadline_day: 3, delivery_deadline_hour: Time.now)
farm_office2 = FarmOffice.create!(office: office2, farm: jonas, delivery_day: 1, delivery_deadline_day: 3, delivery_deadline_hour: Time.now)
farm_office3 = FarmOffice.create!(office: office3, farm: meleze, delivery_day: 1, delivery_deadline_day: 3, delivery_deadline_hour: Time.now)
farm_office4 = FarmOffice.create!(office: office4, farm: cave, delivery_day: 1, delivery_deadline_day: 3, delivery_deadline_hour: Time.now)
farm_office5 = FarmOffice.create!(office: office5, farm: gallien, delivery_day: 1, delivery_deadline_day: 3, delivery_deadline_hour: Time.now)

order = Order.create!(buyer: user1, price_cents: 100, price_currency: 4)

farm_order = FarmOrder.create!(order: order, farm: henry, express_shipping: true, price_cents: 100, shipping_price: 9)
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
