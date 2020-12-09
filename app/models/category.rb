class Category < ApplicationRecord
  has_many :farm_categories
  has_many :farms, through: :farm_categories
  has_many :products, dependent: :destroy

  CATEGORIES = ["Viande & Volaille", "Produits laitiers", "Poisson", "Fruits & Légumes", "Boulangerie", "Oeuf", "Céréales-Farines", "Huile & Vinaigre", "Vins", "Divers", "Produit de la ferme", "Boissons"]

  has_one_attached :photo

  validates :name, presence: true
end
