class Category < ApplicationRecord
  has_many :farm_categories
  has_many :farms, through: :farm_categories

  CATEGORIES = ["Boucherie", "Produits de la ferme", "Fromage", "Poisson", "Légume", "Fruits", "Pain", "Oeuf"]
  validates :name, inclusion: { in: CATEGORIES }
end
