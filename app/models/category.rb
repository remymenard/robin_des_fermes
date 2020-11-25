class Category < ApplicationRecord
  has_many :farm_categories
  has_many :farms, through: :farm_categories

  has_one_attached :photo

  CATEGORIES = ["Viande", "Laitier", "Poisson", "Fruit", "Boulangerie", "Oeuf", "Céréale", "Huile", "Vin", "Divers"]
  validates :name, inclusion: { in: CATEGORIES }
end
