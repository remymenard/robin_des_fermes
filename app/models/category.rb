class Category < ApplicationRecord
  has_many :farm_categories
  has_many :farms, through: :farm_categories

  CATEGORIES = ["Viande", "Laitier", "Poisson", "Fruit", "Boulangerie", "Oeuf", "Céréale", "Huile & Vinaigre", "Vin", "Divers"]
  has_one_attached :photo

  validates :name, inclusion: { in: CATEGORIES }
end
